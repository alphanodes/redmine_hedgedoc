class CodimdQuery < Query
  self.queried_class = Codimd
  self.view_permission = :show_codimd_pads

  self.available_columns = [
    QueryColumn.new(:id, sortable: "#{DbEntry.table_name}.id", default_order: 'desc', caption: '#', frozen: true),
    QueryColumn.new(:name, sortable: "#{DbEntry.table_name}.name", frozen: true),
    QueryColumn.new(:type, sortable: "#{DbEntry.table_name}.type_id", groupable: true),
    QueryColumn.new(:status_id, sortable: "#{DbEntry.table_name}.status_id", groupable: true, caption: :label_db_entry_status),
    QueryColumn.new(:is_private, sortable: "#{DbEntry.table_name}.is_private", groupable: true),
    QueryColumn.new(:project, sortable: "#{Project.table_name}.name", groupable: true),
    QueryColumn.new(:tags),
    QueryColumn.new(:created_at, sortable:  "#{DbEntry.table_name}.created_at", default_order: 'desc', caption: :field_created_on),
    QueryColumn.new(:updated_at, sortable:  "#{DbEntry.table_name}.updated_at", default_order: 'desc', caption: :field_updated_on),
    QueryColumn.new(:assigned_to, sortable: -> { User.fields_for_order_statement('users') }, groupable: true),
    QueryColumn.new(:author, sortable: -> { User.fields_for_order_statement('users') }, groupable: true)
  ]

  def initialize(attributes = nil, *_args)
    super attributes
    self.filters ||= { 'status_id' => { operator: '=', values: [DbEntry::STATUS_VALID.to_s] } }
  end

  def default_sort_criteria
    [%w[name asc]]
  end

  def default_columns_names
    @default_columns_names ||= begin
      default_columns = %i[name type updated_at]
      project.present? ? default_columns : [:project] | default_columns
    end
  end

  def initialize_available_filters
    if project.nil?
      add_available_filter('project_id',
                           type: :list,
                           values: -> { project_values })
    end

    if project && !project.leaf?
      add_available_filter('subproject_id',
                           type: :list_subprojects,
                           values: -> { subproject_values })
    end

    add_available_filter 'name', type: :text
    add_available_filter 'created_at', type: :date, label: :field_created_on
    add_available_filter 'updated_at', type: :date_past, label: :field_updated_on

    add_available_filter 'db_id', type: :integer, label: :label_db_entry

    add_available_filter 'tags',
                         type: :list,
                         values: DbEntry.available_tags(project.blank? ? {} : { project: project.id }).collect { |t| [t.name, t.name] }

    if author_values.present?
      add_available_filter('author_id', type: 'list_optional', values: author_values)
      add_available_filter('assigned_to_id', type: 'list_optional', values: author_values)
    end
  end

  def sql_for_is_private_field(_field, operator, value)
    op = (operator == '=' ? 'IN' : 'NOT IN')
    va = value.map { |v| v == '0' ? self.class.connection.quoted_false : self.class.connection.quoted_true }.uniq.join(',')
    "#{DbEntry.table_name}.is_private #{op} (#{va})"
  end

  def sql_for_db_id_field(_field, operator, value)
    if operator == '='
      # accepts a comma separated list of ids
      ids = value.first.to_s.scan(/\d+/).map(&:to_i)
      if ids.present?
        "#{DbEntry.table_name}.id IN (#{ids.join(',')})"
      else
        '1=0'
      end
    else
      sql_for_field('id', operator, value, DbEntry.table_name, 'id')
    end
  end

  def sql_for_tags_field(field, _operator, value)
    AdditionalsTag.sql_for_tags_field(DbEntry, operator_for(field), value)
  end

  def db_entry_count
    objects_scope.count
  rescue ::ActiveRecord::StatementInvalid => e
    raise StatementInvalid, e.message
  end

  def db_entry_count_by_group
    r = nil
    if grouped?
      begin
        r = objects_scope
            .joins(joins_for_order_statement(group_by_statement))
            .group(group_by_statement).count
      rescue ActiveRecord::RecordNotFound
        r = { nil => db_entry_count }
      end
      c = group_by_column
      r = r.keys.each_with_object({}) { |h, k| h[c.custom_field.cast_value(k)] = r[k] } if c.is_a?(QueryCustomFieldColumn)
    end
    r
  rescue ::ActiveRecord::StatementInvalid => e
    raise StatementInvalid, e.message
  end

  def base_scope
    DbEntry.visible.joins(:project).where(statement)
  end

  def objects_scope(options = {})
    scope = DbEntry.visible
    options[:search].split(' ').map { |search_string| scope = scope.live_search(search_string) } if options[:search].present?
    scope = scope.includes((query_includes + (options[:include] || [])).uniq)
                 .where(statement)
                 .where(options[:conditions])
    scope
  end

  def results_scope(options = {})
    order_option = [group_by_sort_order, (options[:order] || sort_clause)].flatten.reject(&:blank?)

    objects_scope(options)
      .order(order_option)
      .joins(joins_for_order_statement(order_option.join(',')))
      .limit(options[:limit])
      .offset(options[:offset])
  rescue ::ActiveRecord::StatementInvalid => e
    raise StatementInvalid, e.message
  end

  def query_includes
    %i[type project author]
  end
end

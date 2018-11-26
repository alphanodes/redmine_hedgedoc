class CodimdPad
  # find pads (private pads and prefixed project pads)
  # prefix is defined: "project_identifier: "
  # e.g. ["open", "test_projekt"]
  def self.pads(project)
    scope = CodimdNote.joins(:User)
                      .where('title is NOT NULL')

    scope = if project
              scope.where("permission!='private' OR email IN(:mails)", mails: User.current.mails)
                   .where('LOWER(title) LIKE ?', "#{project.identifier}:%")
            else
              prefixes = CodimdPad.project_identifier
              scope.where("permission!='private' OR email IN(:mails)", mails: User.current.mails)

              if prefixes.present?
                scope.where("permission!='private' OR email IN(:mails)", mails: User.current.mails)
                sql = '(email IN(:mails))'
                sql << " OR (permission!='private' AND ("
                prefix_line = []
                prefixes.each do |prefix|
                  prefix_line << "LOWER(title) LIKE '#{prefix}:%'"
                end
                sql << prefix_line.join(' OR ')
                sql << '))'
              end
              scope.where(sql, mails: User.current.mails)
            end
    scope
  end

  # Fix problem with PostgreSQL table names and sort_clause method
  def self.fix_sort_clause(sort_clause)
    keys = []
    sort_clause.each do |f|
      p = f.split(' ')
      sort_field = p[0].to_sym
      sort_order = p[1].to_sym
      keys << { "#{sort_field}": sort_order }
    end

    keys
  end

  # Get all project identifier of the current user
  def self.project_identifier
    Project.where(Project.allowed_to_condition(User.current, :show_codimd_pads)).pluck(:identifier)
  end
end

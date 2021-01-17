class HedgedocPad
  class << self
    # find pads (private pads and prefixed project pads)
    # prefix is defined: "project_identifier: "
    # e.g. ["open", "test_projekt"]
    def pads(project)
      scope = HedgedocNote.joins(:User)
                          .where.not(title: nil, Users: { email: nil })

      scope = scope.where.not(permission: 'private')
                   .or(scope.where(Users: { email: User.current.mails }))

      like_values = project_identifier_like_values project
      return scope if like_values.blank?

      pscope = scope.where 'LOWER(title) LIKE ?', like_values.shift
      # if more are available run loop
      like_values.each do |like_value|
        pscope = pscope.or(scope.where('LOWER(title) LIKE ?', like_value))
      end

      pscope
    end

    # Fix problem with PostgreSQL table names and sort_clause method
    def fix_sort_clause(sort_clause)
      keys = []
      sort_clause.each do |f|
        p = f.split
        sort_field = p[0].to_sym
        sort_order = p[1].to_sym
        keys << { "#{sort_field}": sort_order }
      end

      keys
    end

    private

    # Get all project identifier of the current user
    def project_identifiers
      Project.where(Project.allowed_to_condition(User.current, :show_hedgedoc_pads))
             .pluck(:identifier)
    end

    def project_identifier_like_values(project)
      likes = []
      if project
        likes << "#{project.identifier}:%"
      else
        project_identifiers.each do |identifier|
          likes << "#{identifier}:%"
        end
      end

      likes
    end
  end
end

class CodimdPad
  def self.pads
    prefixes = CodimdPad.project_identifier
    CodimdNote.joins(:User)
              .where('title is NOT NULL')
              .where('email is NOT NULL')
              .where("permission!='private' OR email IN(:mails)", mails: User.current.mails)
  end

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

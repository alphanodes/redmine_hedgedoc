require_dependency 'redmine_codimd'

Redmine::Plugin.register :redmine_codimd do
  name 'Redmine CodiMD'
  url 'https://github.com/alphanodes/redmine_codimd'
  description 'Redmine plugin for CodiMD integration'
  version '1.0.1'
  author 'AlphaNodes GmbH'
  author_url 'https://alphanodes.com/'

  begin
    requires_redmine_plugin :additionals, version_or_higher: '2.0.22'
  rescue Redmine::PluginNotFound
    raise 'Please install additionals plugin (https://github.com/alphanodes/additionals)'
  end

  project_module :codimd do
    permission :show_codimd_pads, codimds: %i[show]
    permission :import_codimd_pads, codimds: %i[import]
  end

  settings default: Additionals.load_settings('redmine_codimd'), partial: 'settings/codimd'

  menu :top_menu,
       :codimd,
       { controller: 'codimds', action: 'show', project_id: nil },
       caption: :project_module_codimd,
       if: (proc do
         User.current.allowed_to?({ controller: 'codimds', action: 'show' }, nil, global: true) &&
         RedmineCodimd.setting(:codimd_in_menu) == 'top'
       end)
  menu :application_menu,
       :codimd,
       { controller: 'codimds', action: 'show', project_id: nil },
       caption: :project_module_codimd,
       if: (proc do
         User.current.allowed_to?({ controller: 'codimds', action: 'show' }, nil, global: true) &&
         RedmineCodimd.setting(:codimd_in_menu) == 'app'
       end)
  menu :project_menu,
       :codimds,
       { controller: 'codimds', action: 'show' },
       caption: :project_module_codimd,
       param: :project_id
end

begin
  if ActiveRecord::Base.connection.table_exists?(Setting.table_name)
    Rails.configuration.to_prepare do
      RedmineCodimd.setup
    end
  end
rescue ActiveRecord::NoDatabaseError
  Rails.logger.error 'database not created yet'
end

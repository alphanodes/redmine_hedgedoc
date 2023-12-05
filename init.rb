# frozen_string_literal: true

loader = RedminePluginKit::Loader.new plugin_id: 'redmine_hedgedoc'

Redmine::Plugin.register :redmine_hedgedoc do
  name 'HedgeDoc integration'
  url 'https://github.com/alphanodes/redmine_hedgedoc'
  description 'Redmine plugin for HedgeDoc integration'
  version RedmineHedgedoc::VERSION
  author 'AlphaNodes GmbH'
  author_url 'https://alphanodes.com/'

  begin
    requires_redmine_plugin :additionals, version_or_higher: '3.0.6'
  rescue Redmine::PluginNotFound
    raise 'Please install additionals plugin (https://github.com/alphanodes/additionals)'
  end

  project_module :hedgedoc do
    permission :show_hedgedoc_pads, hedgedocs: %i[show]
    permission :import_hedgedoc_pads, hedgedocs: %i[import]
  end

  settings default: loader.default_settings,
           partial: 'settings/hedgedoc'

  menu :top_menu,
       :hedgedoc,
       { controller: 'hedgedocs', action: 'show', project_id: nil },
       caption: :label_hedgedoc_pads,
       if: (proc do
         User.current.allowed_to?({ controller: 'hedgedocs', action: 'show' }, nil, global: true) &&
         RedmineHedgedoc.setting(:hedgedoc_in_menu) == 'top'
       end)
  menu :application_menu,
       :hedgedoc,
       { controller: 'hedgedocs', action: 'show', project_id: nil },
       caption: :label_hedgedoc_pads,
       if: (proc do
         User.current.allowed_to?({ controller: 'hedgedocs', action: 'show' }, nil, global: true) &&
         RedmineHedgedoc.setting(:hedgedoc_in_menu) == 'app'
       end)
  menu :project_menu,
       :hedgedocs,
       { controller: 'hedgedocs', action: 'show' },
       caption: :label_hedgedoc_pads,
       param: :project_id
end

RedminePluginKit::Loader.persisting { loader.load_model_hooks! }

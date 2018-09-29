module RedmineCodimd
  class << self
    include Additionals::Helpers

    def setup
      # Patches
      Additionals.patch(%w[QueriesHelper], 'redmine_codimd')

      # Helper
      SettingsController.send :helper, CodimdsHelper
    end

    def settings
      if Rails.version >= '5.2'
        Setting[:plugin_redmine_codimd]
      else
        ActionController::Parameters.new(Setting[:plugin_redmine_codimd])
      end
    end

    def setting?(value)
      Additionals.true?(settings[value])
    end
  end
end

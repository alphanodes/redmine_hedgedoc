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
      Additionals.settings_compatible(:plugin_redmine_codimd)
    end

    def setting?(value)
      Additionals.true?(settings[value])
    end
  end
end

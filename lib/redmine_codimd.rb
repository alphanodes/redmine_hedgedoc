module RedmineCodimd
  class << self
    include Additionals::Helpers

    def setup
      # Helper
      SettingsController.send :helper, CodimdsHelper
    end

    # support with default setting as fall back
    def setting(value)
      if settings.key? value
        settings[value]
      else
        Additionals.load_settings('redmine_codimd')[value]
      end
    end

    def setting?(value)
      Additionals.true?(settings[value])
    end

    private

    def settings
      Additionals.settings_compatible(:plugin_redmine_codimd)
    end
  end
end

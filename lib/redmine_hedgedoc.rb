module RedmineHedgedoc
  class << self
    include Additionals::Helpers

    def setup
      # Helper
      SettingsController.send :helper, HedgedocsHelper
    end

    # support with default setting as fall back
    def setting(value)
      if settings.key? value
        settings[value]
      else
        Additionals.load_settings('redmine_hedgedoc')[value]
      end
    end

    def setting?(value)
      Additionals.true? settings[value]
    end

    private

    def settings
      Setting[:plugin_redmine_hedgedoc]
    end
  end
end

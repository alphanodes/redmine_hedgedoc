# frozen_string_literal: true

require 'redmine_hedgedoc/version'

module RedmineHedgedoc
  class << self
    include Additionals::Helpers

    def setup
      loader = AdditionalsLoader.new plugin_id: 'redmine_hedgedoc'

      # Helper
      loader.add_helper({ controller: 'Settings', helper: 'Hedgedocs' })

      # Apply patches and helper
      loader.apply!
    end

    # support with default setting as fall back
    def setting(value)
      if settings.key? value
        settings[value]
      else
        AdditionalsLoader.default_settings('redmine_hedgedoc')[value]
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

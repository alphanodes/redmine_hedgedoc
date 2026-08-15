# frozen_string_literal: true

module RedmineHedgedoc
  VERSION = '1.1.0'

  include RedminePluginKit::PluginBase

  class << self
    private

    def setup
      # Helper
      loader.add_helper({ controller: 'Settings', helper: 'hedgedocs' })

      # Apply patches and helper
      loader.apply!
    end
  end
end

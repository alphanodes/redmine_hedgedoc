# frozen_string_literal: true

module RedmineHedgedoc
  module Hooks
    class ModelHook < Redmine::Hook::Listener
      def after_plugins_loaded(_context = {})
        RedmineHedgedoc.setup!
      end
    end
  end
end

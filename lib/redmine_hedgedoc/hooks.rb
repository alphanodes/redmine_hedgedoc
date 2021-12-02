# frozen_string_literal: true

module RedmineHedgedoc
  module Hooks
    class RedmineHedgedocHooksListener < Redmine::Hook::ViewListener
      def after_plugins_loaded(_context = {})
        RedmineHedgedoc.setup if Rails.version > '6.0'
      end
    end
  end
end

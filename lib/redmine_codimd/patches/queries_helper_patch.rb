module RedmineCodimd
  module Patches
    # Overwrite QueriesHelper
    module QueriesHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method :column_value_without_codimd, :column_value
          alias_method :column_value, :column_value_with_codimd

          alias_method :csv_value_without_codimd, :csv_value
          alias_method :csv_value, :csv_value_with_codimd
        end
      end

      # Instance methods to add customize values
      module InstanceMethods
        def csv_value_with_codimd(column, object, value)
          csv_value_without_codimd(column, object, value)
        end

        def column_value_with_codimd(column, list_object, value)
          column_value_without_codimd(column, list_object, value)
        end
      end
    end
  end
end

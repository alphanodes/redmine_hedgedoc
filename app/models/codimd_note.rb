class CodimdNote < ActiveRecord::Base
  include CodimdDatabase
  self.table_name = 'Notes'
end

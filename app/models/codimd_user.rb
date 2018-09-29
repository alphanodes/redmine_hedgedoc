class CodimdUser < ActiveRecord::Base
  include CodimdDatabase
  self.table_name = 'Users'
end

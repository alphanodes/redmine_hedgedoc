class CodimdUser < ActiveRecord::Base
  include CodimdDatabase
  self.table_name = 'Users'

  # id
  # profileid
  # profile
  # email
end

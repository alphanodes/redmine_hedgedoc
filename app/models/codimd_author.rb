class CodimdAutor < ActiveRecord::Base
  include CodimdDatabase
  self.table_name = 'Authors'

  # id
  # color
  # noteId
  # userId
  # createdAt
  # updatedAt
end

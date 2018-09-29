class CodimdNote < ActiveRecord::Base
  include CodimdDatabase
  self.table_name = 'Notes'

  # id
  # ownerId
  # content
  # title
  # createdAt
  # updatedAt
  # shortid
  # permission
  # viewcount
  # lastchangeuserId
  # lastchangeAt
  # alias
  # savedAt
end

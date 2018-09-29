class CodimdNote < ActiveRecord::Base
  include CodimdDatabase
  self.table_name = 'Notes'

  belongs_to :User, class_name: 'CodimdUser', foreign_key: 'ownerId', inverse_of: false

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

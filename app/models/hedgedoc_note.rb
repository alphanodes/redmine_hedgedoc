# frozen_string_literal: true

class HedgedocNote < ActiveRecord::Base
  include HedgedocDatabase
  self.table_name = 'Notes'

  belongs_to :User, class_name: 'HedgedocUser', foreign_key: 'ownerId', inverse_of: false

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

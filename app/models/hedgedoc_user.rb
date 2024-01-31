# frozen_string_literal: true

class HedgedocUser < Rails.version < '7.1' ? ActiveRecord::Base : ApplicationRecord
  include HedgedocDatabase
  self.table_name = 'Users'

  has_many :Notes, dependent: :destroy, foreign_key: 'id', inverse_of: :ownerId

  # id
  # profileid
  # profile
  # email
end

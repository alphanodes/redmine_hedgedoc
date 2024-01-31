# frozen_string_literal: true

class HedgedocAuthor < Rails.version < '7.1' ? ActiveRecord::Base : ApplicationRecord
  include HedgedocDatabase
  self.table_name = 'Authors'

  # id
  # color
  # noteId
  # userId
  # createdAt
  # updatedAt
end

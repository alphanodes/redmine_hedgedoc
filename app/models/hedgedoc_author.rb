# frozen_string_literal: true

class HedgedocAuthor < ApplicationRecord
  include HedgedocDatabase
  self.table_name = 'Authors'

  # id
  # color
  # noteId
  # userId
  # createdAt
  # updatedAt
end

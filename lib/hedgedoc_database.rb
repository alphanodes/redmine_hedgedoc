# Abstraction to connect to the second database
module HedgedocDatabase
  extend ActiveSupport::Concern

  included do
    establish_connection :hedgedoc
    self.inheritance_column = :_type_disabled
  end
end

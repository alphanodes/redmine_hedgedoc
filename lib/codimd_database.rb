# Abstraction to connect to the second database
module CodimdDatabase
  extend ActiveSupport::Concern

  included do
    establish_connection :codimd
    self.inheritance_column = :_type_disabled
  end
end

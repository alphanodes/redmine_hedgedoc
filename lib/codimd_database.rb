# Abstraction to connect to the second database
module CodimdDatabase
  def self.included(base)
    base.class_eval do
      establish_connection :codimd
      self.inheritance_column = :_type_disabled
    end
  end
end

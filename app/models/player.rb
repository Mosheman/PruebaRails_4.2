class Player
  include Mongoid::Document
  field :name, type: String
  field :money, type: Integer
end

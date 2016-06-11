class Player
  include Mongoid::Document
  field :name, type: String
  field :money, type: Integer, default: 10000
end

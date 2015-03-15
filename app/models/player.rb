class Player
  include Mongoid::Document

  has_many :player_locations

  field :name, type: String
  field :experience, type: Integer
  field :hitpoints, type: Integer
  field :attack, type: Integer
  field :defense, type: Integer
  field :gold, type: Integer

end

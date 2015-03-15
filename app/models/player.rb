class Player
  include Mongoid::Document

  has_one :user

  field :name, type: String
  field :hitpoints, type: Integer
  field :attack, type: Integer
  field :defense, type: Integer
  field :gold, type: Integer

end

class Player
  include Mongoid::Document

  CURRENT_ID = "current"

  has_many :player_locations
  has_one :current_location, class_name: "PlayerLocation"

  field :name, type: String
  field :experience, type: Integer
  field :hitpoints, type: Integer
  field :attack, type: Integer
  field :defense, type: Integer
  field :gold, type: Integer

  def current_location_url
    current_location.try(:url) || "/"
  end

end

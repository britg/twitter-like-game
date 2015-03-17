class Player
  include Mongoid::Document

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

  def is_current_player!
    @id_proxy = "current"
    self
  end

  def id_proxy
    @id_proxy
  end

end

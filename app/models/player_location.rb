class PlayerLocation
  include Mongoid::Document

  belongs_to :player
  belongs_to :location
  embeds_many :player_landmarks

end
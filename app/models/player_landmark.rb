class PlayerLandmark
  include Mongoid::Document

  embedded_in :player_location

  belongs_to :player
  belongs_to :landmark

end
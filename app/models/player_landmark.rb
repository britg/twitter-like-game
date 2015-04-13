class PlayerLandmark
  include Mongoid::Document

  embedded_in :player_location

  field :landmark_id, type: BSON::ObjectId
  field :killed_at, type: DateTime

  def landmark
    player_location.location.landmarks.find(landmark_id)
  end

  def player
    player_location.player
  end

end
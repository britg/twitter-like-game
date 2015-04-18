class PlayerLandmark
  include Mongoid::Document

  embedded_in :player_location

  field :landmark_id, type: BSON::ObjectId
  field :killed_at, type: DateTime

  def landmark
    @landmark ||= player_location.location.landmarks.find(landmark_id)
  end

  delegate :to_s, to: :landmark

  def to_action_key
    "landmark_#{to_s.gsub(/\s+/, '')}".underscore
  end

  def player
    player_location.player
  end

end

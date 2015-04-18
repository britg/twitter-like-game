class LandmarkState
  include Mongoid::Document

  embedded_in :location_state

  field :landmark_id, type: BSON::ObjectId
  field :killed_at, type: DateTime

  def landmark
    @landmark ||= location_state.location.landmarks.find(landmark_id)
  end

  delegate :to_s, to: :landmark

  def to_action_key
    "landmark_#{to_s.gsub(/\s+/, '')}".underscore
  end

  def player
    location_state.player
  end

end

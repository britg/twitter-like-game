class LandmarkState
  include Mongoid::Document

  embedded_in :location_state

  field :landmark_id, type: BSON::ObjectId
  field :killed_at, type: DateTime

  def landmark
    @landmark ||= location_state.location.landmarks.find(landmark_id)
  end

  delegate :to_s, to: :landmark
  delegate :obj, to: :landmark
  delegate :slug, to: :landmark

  def to_action_key
    "landmark->#{id}"
  end

  def player
    location_state.player
  end

end

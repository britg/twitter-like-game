class LandmarkState
  include Mongoid::Document

  embedded_in :location_state

  field :landmark_id, type: BSON::ObjectId
  field :slug, type: String

  def landmark
    @landmark ||= location_state.location.landmarks.find(landmark_id)
  end

  delegate :to_s, to: :landmark
  delegate :obj, to: :landmark

  def to_action_key
    "landmark->#{slug}"
  end

  def player
    location_state.player
  end

  def obj_instance
    
  end

end

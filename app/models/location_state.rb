class LocationState
  include Mongoid::Document

  belongs_to :player
  belongs_to :location
  embeds_many :landmark_states

  delegate :slug, to: :location

  field :observed_details, type: Array, default: []

end

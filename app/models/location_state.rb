class LocationState
  include Mongoid::Document

  belongs_to :player
  belongs_to :location
  embeds_many :landmark_states

  delegate :slug, to: :location
  delegate :name, to: :location
  delegate :zone, to: :location

  field :seen_story, type: Boolean, default: false
  field :observed, type: Boolean, default: false
  field :observed_details, type: Array, default: []

  field :battle_count, type: Integer, default: 0
  field :resource_node_count, type: Integer, default: 0

  def self.slug(slug)
    l = Location.slug(slug)
    where(location_id: l.id).first
  end

  def current_location?
    player.location_id == location_id
  end

end

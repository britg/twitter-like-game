class Landmark
  include Mongoid::Document
  include HasRarity

  TYPES = ["Location"]

  embedded_in :location

  field :name, type: String
  field :slug, type: String
  field :type, type: String
  field :moves, type: Boolean, default: false
  field :auto_discovered, type: Boolean, default: false

  field :discovery_details, type: Array

  # Pacing
  field :required_battle_count, type: Integer, default: 1
  field :required_resource_node_count, type: Integer, default: 1

  validates_inclusion_of :type, in: TYPES

  def obj_class
    type.constantize
  end

  def obj
    obj_class.where(slug: slug).first
  end

  def to_s
    name || obj.to_s
  end

  def npc?
    type == "Npc"
  end

  def resource?
    type == "Resource"
  end

  def location?
    type == "Location"
  end

  def discovery_detail
    return default_discovery_detail unless discovery_details.present?
    discovery_details.sample
  end

  def default_discovery_detail
    "You discover #{to_s}"
  end

end

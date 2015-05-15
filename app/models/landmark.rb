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
  field :start_interaction_details, type: Array

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

  def start_interaction_detail
    return default_start_interaction_detail unless start_interaction_details.present?
    start_interaction_details.sample
  end

  def default_start_interaction_detail
    "..."
  end

end

class Landmark
  include Mongoid::Document

  TYPES = ["Resource", "Npc", "Location"]

  embedded_in :location
  embeds_many :discovery_requirements, class_name: "SkillRequirement"

  field :slug, type: String
  field :type, type: String
  field :object_id, type: BSON::ObjectId
  field :moves, type: Boolean, default: false
  field :auto_discovered, type: Boolean, default: false

  field :discovery_details, type: Array
  field :start_interaction_details, type: Array

  validates_inclusion_of :type, in: TYPES

  def set_object obj
    self.type = obj.class.to_s
    self.object_id = obj.id
  end

  def set_object! obj
    set_object(obj)
    save
  end

  def obj_class
    type.constantize
  end

  def obj= thing
    set_object(thing)
  end

  def obj
    obj_class.where(id: object_id).first
  end

  def to_s
    obj.to_s
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

  def discovery_req= params
    arr = Array(params)
    arr.each do |p|
      discovery_requirements.build(p)
    end
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
    "You approach #{to_s}..."
  end

end

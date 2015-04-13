class Landmark
  include Mongoid::Document

  TYPES = ["Resource", "Npc"]

  embedded_in :location
  embeds_many :discovery_conditions, class_name: "SkillRequirement"
  embeds_many :aggro_conditions, class_name: "SkillRequirement"

  field :type, type: String
  field :object_id, type: BSON::ObjectId
  field :respawn_delay, type: Integer, default: 0
  field :moves, type: Boolean, default: false
  field :discovery_details, type: Array
  field :aggro_details, type: Array

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

  def discovery_req= params
    arr = Array(params)
    arr.each do |p|
      discovery_conditions.build(p)
    end
  end

  def aggro_req= params
    arr = Array(params)
    arr.each do |p|
      aggro_conditions.build(p)
    end
  end

  def to_s
    obj.to_s
  end

  def aggro_detail
    aggro_details.sample
  end

  def discovery_detail
    discovery_details.sample
  end

end
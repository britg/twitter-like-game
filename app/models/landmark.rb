class Landmark
  include Mongoid::Document

  TYPES = ["Resource", "Npc"]

  embedded_in :location

  field :type, type: String
  field :object_id, type: BSON::ObjectId
  field :required_perception, type: Float, default: 10

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

  def obj
    obj_class.where(id: object_id).first
  end

end
class ActionSerializer < ActiveModel::Serializer
  attributes :id, :key, :label, :event_id

  def event_id
    object.event.id.to_s
  end
end

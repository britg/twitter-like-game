class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :character_name,
             :detail,
             :dialogue,
             :location_id,
             :event_template_id

  has_many :actions
end

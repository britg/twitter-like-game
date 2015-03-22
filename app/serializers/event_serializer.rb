class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :character_name,
             :detail,
             :dialogue,
             :actions,
             :location_id,
             :event_template_id
end

class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :character_name,
             :detail,
             :dialogue,

end

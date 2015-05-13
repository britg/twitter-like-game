class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :type,
             :character_name,
             :detail,
             :dialogue

end

class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :character_name,
             :detail,
             :dialogue,
             :location_id,
             :chosen_action_key,
             :current_state

  has_many :actions
end

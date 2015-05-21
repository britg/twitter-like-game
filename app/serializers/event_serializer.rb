class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :format,
             :chosen_action_key,
             :character_name,
             :detail,
             :dialogue,
             :attacker, :attacker_id,
             :target, :target_id,
             :delta,
             :resource_name,
             :location_name,
             :landmark_name, :landmark_slug,
             :gold,
             :equipment_name, :equipment_id,
             :player_id,
             :player_state_during_event

end

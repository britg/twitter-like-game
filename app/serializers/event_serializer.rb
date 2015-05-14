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
             :landmark_name, :landmark_slug,
             :player_id,
             :player_state_during_event

end

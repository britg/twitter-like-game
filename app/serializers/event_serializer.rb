class EventSerializer < ActiveModel::Serializer
  root :nil
  attributes :id,
             :type,
             :chosen_action_key,
             :character_name,
             :detail,
             :dialogue,
             :attacker, :attacker_id,
             :target, :target_id,
             :delta,
             :landmark_name, :landmark_slug,
             :player_id,
             :player

  def player
    PlayerSerializer.new(object.player, root: nil)
  end

end

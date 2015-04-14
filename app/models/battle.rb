class Battle
  include Mongoid::Document

  embeds_many :participants

  def player_ids
    participants.map(&:player_id).compact
  end

  def players
    Player.find(player_ids)
  end

  def npc_ids
    participants.map(&:npc_id).compact
  end

  def npcs
    Npc.find(npc_ids)
  end

  def agents
    (players.map(&:agent) | participants.map(&:agent)).compact
  end

end

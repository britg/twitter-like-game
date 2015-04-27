class Battle
  include Mongoid::Document

  DEFAULT_INITIATIVE = 100

  embeds_many :participants

  field :combined_initiative, type: Integer, default: DEFAULT_INITIATIVE

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

  def npc_participants
    participants.ne(npc_id: nil)
  end

  def agents
    (players.map(&:agent) | participants.map(&:agent)).compact
  end

end

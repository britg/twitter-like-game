class Participant
  include Mongoid::Document

  belongs_to :player

  belongs_to :npc
  embeds_one :agent

  embedded_in :battle

  def to_s
    (player||npc).to_s
  end

  def npc?
    npc_id.present?
  end

  def player?
    player_id.present?
  end

end
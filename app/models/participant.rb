class Participant
  include Mongoid::Document

  belongs_to :player

  belongs_to :npc
  embeds_one :agent_instance, class_name: "Agent"

  embedded_in :battle

  field :current_initiative, type: Integer, default: 0

  def obj
    return @obj if @obj.present?
    return @obj = player if player?
    @obj = npc if npc?
  end

  def to_s
    (player||npc).to_s
  end

  def ap
    obj.ap
  end

  def npc?
    npc_id.present?
  end

  def player?
    player_id.present?
  end

end

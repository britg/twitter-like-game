class Participant
  include Mongoid::Document

  belongs_to :player
  belongs_to :npc
  belongs_to :combat_profile
  embeds_one :agent_instance, class_name: "Agent"
  alias_method :agent, :agent_instance
  embedded_in :battle

  field :name, type: String
  field :current_initiative, type: Integer, default: 0
  field :active, type: Boolean, default: true
  field :status, type: String

  def self.active
    where(active: true)
  end

  def obj
    return @obj if @obj.present?
    return @obj = player if player?
    @obj = agent_instance if npc?
  end

  def to_s
    name
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

  def dead?
    obj.dead?
  end

end

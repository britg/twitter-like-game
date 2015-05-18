class Npc
  include Mongoid::Document
  include HasAgent

  belongs_to :npc_blueprint

  field :name
  belongs_to :combat_profile

  delegate :observation_details, to: :npc_blueprint
  delegate :loot_profile, to: :npc_blueprint

  def to_s
    name
  end

  def player?
    false
  end

end

class Agent
  include Mongoid::Document

  embedded_in :player
  embedded_in :npc

  embeds_many :stats, class_name: "AgentStat"
  embeds_many :slots, class_name: "AgentSlot"
  embeds_many :skills, class_name: "AgentSkill"

  def attack
    # AttackCalculator.new(self).result
  end

  def hp
    # HitpointCalculator.new(self).result
  end

  def ap
    # ActionpointCalculator.new(self).result
  end

  def equip item
    raise "Item not equippable #{item}" unless item.equippable?

  end

end
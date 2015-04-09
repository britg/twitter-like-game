class Agent
  include Mongoid::Document

  embedded_in :player
  embedded_in :npc

  field :base_strength
  field :base_dexterity
  field :base_stamina
  field :base_intelligence
  field :base_luck

  field :slots # Array

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
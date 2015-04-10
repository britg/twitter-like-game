class Agent
  include Mongoid::Document

  embedded_in :player
  embedded_in :npc

  field :base_strength, type: Integer
  field :base_dexterity, type: Integer
  field :base_stamina, type: Integer
  field :base_intelligence, type: Integer
  field :base_luck, type: Integer

  field :slots # Array

  embeds_many :skills

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
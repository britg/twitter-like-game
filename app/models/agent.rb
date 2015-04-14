class Agent
  include Mongoid::Document

  embedded_in :player
  embedded_in :npc

  embeds_many :stats, class_name: "AgentStat"
  embeds_many :slots, class_name: "AgentSlot"
  embeds_many :skills, class_name: "AgentSkill"

  # Convenience Methods

  def str stat(:str); end
  def dex stat(:dex); end
  def stam stat(:stam); end
  def int stat(:int); end
  def luck stat(:luck); end

  def hp stat(:hp); end
  def ap stat(:ap); end
  def mana stat(:mana); end

  def attack stat(:attack); end
  def defense stat(:def); end

  def hit stat(:hit); end
  def dodge stat(:dodge); end

  def stat slug
    stats.where(slug: slug).first.value
  end

  def equip item
    raise "Item not equippable #{item}" unless item.equippable?

  end

end
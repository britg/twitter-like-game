class Agent
  include Mongoid::Document

  embedded_in :player
  embedded_in :npc

  embeds_many :stats, class_name: "AgentStat"
  embeds_many :slots, class_name: "AgentSlot"
  embeds_many :skills, class_name: "AgentSkill"

  # Stats - increase through skills and items

  def str() stat(:str) end
  def dex() stat(:dex) end
  def stam() stat(:stam) end
  def int() stat(:int) end
  def luck() stat(:luck) end
  def aggro() stat(:aggro) end

  def hp() stat(:hp) end
  def ap() stat(:ap) end
  def mana() stat(:mana) end

  # based on current weapon and your skills
  def attack() stat(:attack) end
  def armor() stat(:armor) end
  def hit_chance() stat(:hit_chance) end
  def dodge() stat(:dodge) end
  def magic_resistance() stat(:magic_res) end
  def physical_resistance() stat(:physical_res) end

  # Skills - permanent increase from use
  #        - temporary increase from items

  def adventuring() skill(:adventuring) end

  # Item Slots  - bonuses to stats and skills
  def head() slot(:head) end
  def shoulders() slot(:shoulders) end
  def back() slot(:back) end
  def chest() slot(:chest) end
  def legs() slot(:legs) end
  def feet() slot(:feet) end
  def left_ring() slot(:left_ring) end
  def right_ring() slot(:right_ring) end
  def neck() slot(:neck) end

  def stat slug
    @stat_cache ||= {}
    @stat_cache[slug] ||= stats.find_or_create_by(slug: slug)
  end

  def skill slug
    skills.find_or_create_by(slug: slug)
  end

  def slot slug
    slots.find_or_create_by(slug: slug)
  end

  def equip item
    raise "Item not equippable #{item}" unless item.equippable?
  end


end

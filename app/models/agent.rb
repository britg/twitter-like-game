class Agent
  include Mongoid::Document

  embedded_in :player
  embedded_in :npc

  embeds_many :stats, class_name: "AgentStat"
  embeds_many :slots, class_name: "AgentSlot"
  embeds_many :skills, class_name: "AgentSkill"

  field :level, type: Integer, default: 1
  field :exp, type: Integer, default: 0
  field :current_initiative, type: Integer, default: 0
  field :current_battle_tick, type: Integer, default: 0

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
  def attack_speed() stat(:attack_speed) end # attacks/sec
  def hit_chance() stat(:hit_chance) end
  def crit_chance() stat(:crit_chance) end
  def dodge() stat(:dodge) end
  def magic_resistance() stat(:magic_res) end

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

  def main_hand() slot(:main_hand) end
  def off_hand() slot(:off_hand) end

  def owner
    player||npc
  end

  def stat slug
    stats.find_or_create_by(slug: slug)
  end

  def skill slug
    skills.find_or_create_by(slug: slug)
  end

  def slot slug
    slots.find_or_create_by(slug: slug)
  end

  def dead?
    hp.value < 1
  end

  def apply_delta agent_delta
    # TODO actually implement
    reload
    hp.inc(current_offset: agent_delta.amount)
  end

  def equip equipment
    slot_slug = equipment.slot.slug
    agent_slot = slot(slot_slug)
    agent_slot.update_attributes(equipment: equipment)
  end

  def main_hand_skill
    main_hand.equipment.skill
  end

end

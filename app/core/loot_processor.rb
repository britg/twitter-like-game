class LootProcessor

  def initialize player, loot_profile
    @player = player
    @loot_profile = loot_profile
  end

  def assign_loot
    # TODO Actuall get this from the loot profile
    num_items.times do
      if Rarity.below?(50)
        equipment_loot
      else
        vendor_item_loot
      end
    end
    gold_loot
  end

  def num_items
    # TODO: Read the loot profile to determine num items
    rand(0..3)
  end

  def roll_for_equipment_blueprint
    # TODO: Actually impelment this
    EquipmentBlueprint.find_random
  end

  def equipment_loot
    blueprint = roll_for_equipment_blueprint
    equipment = EquipmentCreator.new(@player, blueprint).create
    @player.add_event(
      format: Event::ITEM,
      equipment_name: equipment.name,
      equipment_id: equipment.id
    )
  end

  def roll_for_vendor_item_blueprint
    # TODO: Actually impelment this
    EquipmentBlueprint.find_random
  end

  def vendor_item_loot
    blueprint = roll_for_vendor_item_blueprint
  end

  def gold_loot
    # TODO get gold amount from loot profile
    amount = rand(0..100)
    @player.inc(gold: amount)
    @player.add_event(
      format: Event::GOLD,
      gold: amount
    )
  end

end
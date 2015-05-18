class LootProcessor

  def initialize player, loot_profile
    @player = player
    @loot_profile = loot_profile
  end

  def assign_loot
    @player.add_event("You get some loot from the loot processor!")
  end

end
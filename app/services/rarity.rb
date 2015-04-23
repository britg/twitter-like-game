class Rarity

  COMMON = "common"
  UNCOMMON = "uncommon"
  RARE = "rare"
  EPIC = "epic"

  COMMON_PERCENTAGE = 75
  UNCOMMON_PERCENTAGE = 15
  RARE_PERCENTAGE = 7
  EPIC_PERCENTAGE = 3

  def self.roll
    Random.rand * 100
  end

  def self.below percentage
    roll < percentage
  end

  def self.rarity
    num = roll
    return COMMON if common?(num)
    return UNCOMMON if uncommon?(num)
    return RARE if rare?(num)
    return EPIC if epic?(num)
  end

  def self.common? num
    num <= COMMON_PERCENTAGE
  end

  def self.uncommon? num
    (COMMON_PERCENTAGE..(COMMON_PERCENTAGE + UNCOMMON_PERCENTAGE)).include?(num)
  end

  def self.rare? num
    ((COMMON_PERCENTAGE + UNCOMMON_PERCENTAGE)..(COMMON_PERCENTAGE + UNCOMMON_PERCENTAGE + RARE_PERCENTAGE)).include?(num)
  end

  def self.epic? num
    ((COMMON_PERCENTAGE + UNCOMMON_PERCENTAGE + RARE_PERCENTAGE)..(COMMON_PERCENTAGE + UNCOMMON_PERCENTAGE + RARE_PERCENTAGE + EPIC_PERCENTAGE)).include?(num)
  end

end

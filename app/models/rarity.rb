class Rarity
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  field :percentage, type: Float

  def self.roll
    Random.rand * 100
  end

  def self.below? percentage
    roll < percentage
  end

  def self.rarity
    num = roll
    ranges.each do |rarity_slug, range|
      if range.include?(num)
        return Rarity.slug(rarity_slug)
      end
    end
  end

  # Set has to have rarity
  def self.sample arr
    chosen_rarity = rarity
    matching = arr.select{ |item| item.rarity == chosen_rarity }
    if matching.count < 1
      arr.sample
    else
      matching.sample
    end
  end

  def self.ranges
    @ranges = {}
    base = 0
    all.each do |rarity|
      @ranges[rarity.slug] = (base..base+rarity.percentage)
      base += rarity.percentage
    end
    @ranges
  end

end

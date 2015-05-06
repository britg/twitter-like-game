class Rarity
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  field :percentage, type: Float

  def self.roll
    Random.rand * 100
  end

  def self.below percentage
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

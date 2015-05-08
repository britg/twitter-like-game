module HasRarity
  extend ActiveSupport::Concern

  included do
    belongs_to :rarity
  end

  def _rarity= slug
    self.rarity = Rarity.slug(slug)
  end

end

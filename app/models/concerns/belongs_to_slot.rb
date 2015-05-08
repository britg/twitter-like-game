module BelongsToSlot
  extend ActiveSupport::Concern

  included do
    belongs_to :slot
  end

  def _slot= slug
    self.slot = Slot.slug(slug)
  end

end

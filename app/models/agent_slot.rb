class AgentSlot
  include Mongoid::Document

  embedded_in :agent
  belongs_to :item

  field :slug, type: String

  def slot
    Slot.slug(:slug)
  end

end
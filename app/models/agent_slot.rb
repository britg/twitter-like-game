class AgentSlot
  include Mongoid::Document

  embedded_in :agent

  field :slug, type: String

  def slot
    Slot.slug(:slug)
  end

end

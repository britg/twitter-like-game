class AgentSlot
  include Mongoid::Document

  embedded_in :agent

  field :slug, type: String
  belongs_to :equipment

  def slot
    Slot.slug(:slug)
  end

end

class AgentSlot
  include Mongoid::Document

  embedded_in :agent
  belongs_to :slot
  belongs_to :item

end
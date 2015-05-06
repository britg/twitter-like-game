class Inventory
  include Mongoid::Document

  belongs_to :player
  belongs_to :npc

end

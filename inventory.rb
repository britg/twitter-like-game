class Inventory
  include Mongoid::Document

  belongs_to :player
  belongs_to :npc
  has_many :item_instances

end

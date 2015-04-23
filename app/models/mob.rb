class Mob
  include Mongoid::Document

  belongs_to :npc

  field :rarity, type: String, default: Rarity::COMMON

end

class Mob
  include Mongoid::Document

  embedded_in :location

  belongs_to :npc

  field :rarity, type: String, default: Rarity::COMMON

  def to_s
    npc.to_s
  end

end

class Mob
  include Mongoid::Document

  embedded_in :location
  belongs_to :npc_blueprint
  field :rarity, type: String, default: Rarity::COMMON

  def to_s
    npc_blueprint.name
  end

end

# A reference to NPC Blueprint in a location,
# with an attached rarity
class Mob
  include Mongoid::Document
  include HasRarity

  embedded_in :location
  belongs_to :npc_blueprint

  def to_s
    npc_blueprint.name
  end

end

# A reference to NPC Blueprint in a location,
# with an attached rarity
class Mob
  include Mongoid::Document

  embedded_in :location
  belongs_to :npc_blueprint
  belongs_to :rarity

  def to_s
    npc_blueprint.name
  end

end

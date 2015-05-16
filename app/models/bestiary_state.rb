class BestiaryState
  include Mongoid::Document

  belongs_to :player, index: true
  belongs_to :npc_blueprint

end
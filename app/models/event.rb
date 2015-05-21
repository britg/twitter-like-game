class Event
  include Mongoid::Document

  DETAIL = "detail"
  ATTACK = "attack"
  SKILL = "skill"
  DISCOVERY = "discovery"
  MOB_APPROACH = "mob_approach"
  AGGRO = "aggro"
  NPC_DEATH = "npc_death"
  ENTRANCE = "entrance"
  RESOURCE = "resource"
  GOLD = "gold"
  ITEM = "item"

  class InvalidAction < Exception; end

  belongs_to :player
  index({player_id: 1})
  index({created_at: -1})

  field :player_state_during_event, type: Hash

  field :format, type: String, default: Event::DETAIL
  field :character_name, type: String
  field :detail, type: String
  field :dialogue, type: String
  field :chosen_action_key, type: String

  # Resource Event
  field :resource_name, type: String

  # Entrance Event
  field :location_name, type: String

  # Discovery Event
  field :landmark_name, type: String
  field :landmark_slug, type: String

  # Attack Event
  field :attacker, type: String
  field :attacker_id, type: String
  field :target, type: String
  field :target_id, type: String
  field :delta, type: String

  # Loot
  field :gold, type: Integer
  field :equipment_name, type: String
  field :equipment_id, type: String

  field :created_at, type: Time

  def to_s
    [character_name, dialogue, detail].compact.join(' : ')
  end

end

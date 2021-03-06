class NpcBlueprint
  include Mongoid::Document
  include HasSlug

  belongs_to :combat_profile
  belongs_to :loot_profile

  field :name, type: String
  field :level, type: Integer, default: 1
  embeds_many :agent_attributes, class_name: "AgentDelta"

  field :observation_details

  def to_s
    name
  end

  def _combat_profile= slug
    self.combat_profile = CombatProfile.slug(slug)
  end

end

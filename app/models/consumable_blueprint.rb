class ConsumableBlueprint
  include Mongoid::Document
  include HasSlug
  include HasRarity

  field :name, type: String
  field :level_requirement, type: Integer

  field :target_type, type: String # Player, Equipment
  field :target_limits, type: Array # slugs of specific slots this can be applied to

  embeds_many :agent_deltas
  embeds_many :agent_requirements

end

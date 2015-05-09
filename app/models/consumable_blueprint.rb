class ConsumableBlueprint
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  embeds_many :agent_deltas

  field :target_type, type: String # Player, Equipment
  field :target_limits, type: Array # slugs of specific slots this can be applied to

end

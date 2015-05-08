class EquipmentBlueprint
  include Mongoid::Document
  include HasSlug
  include HasRarity
  include BelongsToSlot

  belongs_to :slot

  field :base_name, type: String
  validates_presence_of :base_name

  field :level_requirement, type: Integer

  embeds_many :agent_deltas
  embeds_many :agent_requirements

end

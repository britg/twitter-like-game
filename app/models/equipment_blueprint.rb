class EquipmentBlueprint
  include Mongoid::Document
  include HasSlug
  include HasRarity
  include BelongsToSlot

  field :base_name, type: String
  validates_presence_of :base_name

  field :level_requirement, type: Integer
  field :durability_range, type: Range

  embeds_many :agent_deltas
  embeds_many :agent_requirements

  def durability
    rand(durability_range)
  end

end

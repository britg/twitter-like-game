class EquipmentBlueprint
  include Mongoid::Document

  belongs_to :slot
  belongs_to :rarity

  field :base_name, type: String
  validates_presence_of :base_name

  field :level_requirement, type: Integer

  embeds_many :stat_bonuses
  embeds_many :skill_bonuses
  embeds_many :stat_requirements
  embeds_many :skill_requirements

end

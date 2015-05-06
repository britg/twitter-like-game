class Equipment
  include Mongoid::Document

  belongs_to :slot

  has_many :stat_bonuses
  has_many :skill_bonuses

  field :level_requirement
  has_many :stat_requirements
  has_many :skill_requirements

  field :name, type: String
  field :rarity, type: String

end

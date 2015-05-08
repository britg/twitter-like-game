class Equipment
  include Mongoid::Document

  belongs_to :slot

  embeds_many :agent_deltas
  embeds_many :agent_requirements

  field :level_requirement, type: Integer

  field :name, type: String
  belongs_to :rarity

end

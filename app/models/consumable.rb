class Consumable
  include Mongoid::Document
  include HasRarity

  belongs_to :player, index: true

  field :name, type: String
  field :target_type, type: String
  field :level_requirement, type: Integer

  embeds_many :agent_deltas
  embeds_many :agent_requirements

end

class Equipment
  include Mongoid::Document
  include HasRarity

  belongs_to :slot
  belongs_to :player, index: true
  belongs_to :skill

  embeds_many :agent_deltas
  embeds_many :agent_requirements

  field :level_requirement, type: Integer
  field :max_durability, type: Integer
  field :current_durability, type: Integer

  field :name, type: String

end

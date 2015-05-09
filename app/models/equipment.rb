class Equipment
  include Mongoid::Document

  belongs_to :slot
  belongs_to :player

  embeds_many :agent_deltas
  embeds_many :agent_requirements

  field :level_requirement, type: Integer
  field :max_durability, type: Integer
  field :current_durability, type: Integer

  field :name, type: String
  belongs_to :rarity

end

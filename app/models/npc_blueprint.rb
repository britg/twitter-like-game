class NpcBlueprint
  include Mongoid::Document
  include HasSlug

  belongs_to :combat_profile

  field :name, type: String
  embeds_many :agent_deltas

  def to_s
    name
  end

end

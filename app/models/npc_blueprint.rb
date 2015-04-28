class NpcBlueprint
  include Mongoid::Document
  include HasSlug

  belongs_to :combat_profile

  field :name, type: String

  embeds_many :stat_blueprints
  embeds_many :skill_blueprints

  def to_s
    name
  end

end

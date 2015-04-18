class Resource
  include Mongoid::Document
  include HasSlug

  HERB = "herb"
  ORE = "ore"

  # Requirements
  embeds_many :discovery_requirements, class_name: "SkillRequirement"
  embeds_many :harvest_requirements, class_name: "SkillRequirement"

  field :type, type: String
  field :name, type: String

  def to_s
    name
  end

end

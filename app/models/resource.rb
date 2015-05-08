class Resource
  include Mongoid::Document
  include HasSlug

  HERB = "herb"
  ORE = "ore"

  # Requirements

  field :type, type: String
  field :name, type: String

  def to_s
    name
  end

end

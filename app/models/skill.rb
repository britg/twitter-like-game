class Skill
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String
  field :value, type: Float

end
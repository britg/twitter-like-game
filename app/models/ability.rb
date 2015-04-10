class Ability
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String

end
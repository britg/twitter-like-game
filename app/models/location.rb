class Location
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String
  field :path, type: String
  field :entrance_description, type: String

  has_and_belongs_to_many :npcs, inverse_of: nil

end
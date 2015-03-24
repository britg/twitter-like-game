class Location
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String

  validates_uniqueness_of :slug

end

class Location
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String
  field :path, type: String

end
class Location
  include Mongoid::Document

  has_many :player_locations

  field :name, type: String
  field :slug, type: String

end

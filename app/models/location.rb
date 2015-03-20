class Location
  include Mongoid::Document

  embeds_many :scripted_events

  field :name, type: String
  field :slug, type: String

  validates_uniqueness_of :slug

end

class Zone
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  field :description, type: String
  has_many :locations

end

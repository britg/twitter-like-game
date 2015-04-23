class ResourceNode
  include Mongoid::Document

  embedded_in :location

  belongs_to :resource
  field :rarity, type: String, default: Rarity::COMMON

end

class ResourceNode
  include Mongoid::Document

  embedded_in :location

  belongs_to :resource
  belongs_to :rarity

end

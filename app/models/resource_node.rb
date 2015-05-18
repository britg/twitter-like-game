class ResourceNode
  include Mongoid::Document
  include HasRarity

  embedded_in :location

  belongs_to :loot_profile

  field :name, type: String
  field :discovery_details, type: Array
  field :approach_label, type: String, default: "Investigate"

  def to_action_key
    "resource_node->#{id}"
  end

end

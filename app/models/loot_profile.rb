class LootProfile
  include Mongoid::Document
  include HasSlug

  field :name, type: String



end
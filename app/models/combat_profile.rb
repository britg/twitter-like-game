class CombatProfile
  include Mongoid::Document
  include HasSlug

  field :name, type: String

  embeds_many :combat_profile_conditions

end

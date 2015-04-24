class CombatProfileCondition
  include Mongoid::Document

  embedded_in :combat_profile

  # result
  field :match, type: String
  field :result, type: String

end

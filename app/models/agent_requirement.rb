class AgentRequirement
  include Mongoid::Document

  field :type, type: String
  field :slug, type: String
  field :min, type: Float
  field :max, type: Float

end

class Action
  include Mongoid::Document

  field :label, type: String
  field :key, type: String

end

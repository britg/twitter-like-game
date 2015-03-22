class Action
  include Mongoid::Document

  field :key, type: String
  field :label, type: String

end

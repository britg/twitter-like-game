class Action
  include Mongoid::Document

  embedded_in :event

  field :label, type: String
  field :key, type: String

end
class Action
  include Mongoid::Document

  embedded_in :event

  field :key, type: String
  field :label, type: String

end

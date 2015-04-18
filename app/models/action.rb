class Action
  include Mongoid::Document

  embedded_in :event
  recursively_embeds_many

  field :label, type: String
  field :key, type: String

end

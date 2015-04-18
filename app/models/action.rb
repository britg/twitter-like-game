class Action
  include Mongoid::Document

  recursively_embeds_many

  field :label, type: String
  field :key, type: String

end

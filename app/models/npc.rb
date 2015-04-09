class Npc
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String

  embeds_one :agent

end
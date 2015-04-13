class Npc
  include Mongoid::Document
  include HasSlug

  field :name, type: String

  embeds_one :agent

  def to_s
    name
  end

end
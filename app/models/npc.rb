class Npc
  include Mongoid::Document
  include HasSlug

  field :name, type: String

  embeds_one :agent
  delegate :skills, to: :agent
  delegate :stats, to: :agent
  delegate :slots, to: :agent

  def to_s
    name
  end

end
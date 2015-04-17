class Npc
  include Mongoid::Document
  include HasSlug
  include HasAgent

  field :name, type: String

  def to_s
    name
  end

  def player?
    false
  end

end

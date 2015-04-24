class Npc
  include Mongoid::Document
  include HasSlug
  include HasAgent

  belongs_to :combat_profile

  field :name, type: String

  def to_s
    name
  end

  def player?
    false
  end

end

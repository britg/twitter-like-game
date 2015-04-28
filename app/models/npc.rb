class Npc
  include Mongoid::Document
  include HasAgent

  belongs_to :npc_blueprint

  field :name
  belongs_to :combat_profile


  def to_s
    name
  end

  def player?
    false
  end

end

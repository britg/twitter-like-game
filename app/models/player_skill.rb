class PlayerSkill
  include Mongoid::Document

  embedded_in :player

  belongs_to :skill

  field :value, type: Float, default: 0

  def val
    value.round(1)
  end

end
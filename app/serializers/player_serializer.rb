class PlayerSerializer < ActiveModel::Serializer

  attributes :id,
             :name,
             :status_line,
             :level,
             :hp,
             :mana,
             :gold

  has_one :user

  def hp
    object.hp.value
  end

  def ap
    object.ap.value
  end

  def mana
    object.mana.value
  end

end

class PlayerSerializer < ActiveModel::Serializer

  attributes :id,
             :name,
             :experience,
             :level,
             :hp,
             :ap,
             :gold,
             :strength,
             :dexterity,
             :stamina,
             :intelligence,
             :luck

  has_one :location
  has_one :user

end

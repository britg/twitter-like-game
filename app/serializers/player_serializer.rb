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

  has_one :user

  has_many :events, key: :events

  def events
    object.events.order("id desc").limit(20)
  end

end

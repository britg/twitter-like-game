class PlayerSerializer < ActiveModel::Serializer
  attributes :id,
             :name

  has_one :location
  has_one :user

  has_many :events

  def events
    object.events.limit(20)
  end

end

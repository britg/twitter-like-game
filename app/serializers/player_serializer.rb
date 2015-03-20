class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name,
             :current_location_url

  has_one :location
  has_one :user
  has_many :events

end

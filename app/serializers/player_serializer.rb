class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name,
             :current_location_url

  has_one :current_location

end

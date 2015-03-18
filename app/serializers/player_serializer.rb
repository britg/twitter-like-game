class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :new_record?,
             :current_location, :current_location_url

end

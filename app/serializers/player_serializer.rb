class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :new_record?,
             :current_location, :current_location_url

  def id
    object.id_proxy || id
  end

end

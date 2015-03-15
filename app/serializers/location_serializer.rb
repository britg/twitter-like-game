class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name

  def id
    object.slug
  end

end

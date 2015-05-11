class LocationStateSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :current_location?
end

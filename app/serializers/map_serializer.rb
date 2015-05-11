class MapSerializer < ActiveModel::Serializer
  attributes :id, :discoveries, :can_travel
end

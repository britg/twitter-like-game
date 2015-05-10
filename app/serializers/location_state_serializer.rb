class LocationStateSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name

  has_many :landmark_states

end

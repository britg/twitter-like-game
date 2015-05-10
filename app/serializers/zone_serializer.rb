class ZoneSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :description
end

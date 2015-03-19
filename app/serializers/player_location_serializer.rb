class PlayerLocationSerializer < ActiveModel::Serializer
  attributes :id, :url

  attribute :name

end

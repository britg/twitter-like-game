class PlayerSerializer < ActiveModel::Serializer
  attributes :id

  def id
    object.id.to_s
  end
end

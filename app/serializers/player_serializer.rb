class PlayerSerializer < ActiveModel::Serializer

  attributes :id,
             :name,
             :status_line

  has_one :user

end

class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :character_name,
             :detail,
             :dialogue

  def character_name
    object.character.try(:name)
  end

end

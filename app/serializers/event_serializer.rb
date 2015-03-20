class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :character_name,
             :detail,
             :dialogue

  def character_name
    if object.character.present?
      object.character.name
    else
      Player::SELF_EVENT_NAME
    end
  end

end

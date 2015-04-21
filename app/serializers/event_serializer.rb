class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :character_name,
             :detail,
             :dialogue,
             :time_marker

  def time_marker
    object.created_at.to_i
  end

end

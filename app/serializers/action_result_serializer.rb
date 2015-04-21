class ActionResultSerializer < ActiveModel::Serializer
  attributes :player, :events, :actions

  def player
    PlayerSerializer.new(object, root: nil)
  end

  def events
    object.new_events
  end

  def actions
    object.available_actions
  end
end

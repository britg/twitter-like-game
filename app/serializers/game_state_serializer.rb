class GameStateSerializer < ActiveModel::Serializer
  attributes :player, :events, :actions

  def player
    PlayerSerializer.new(object, root: nil)
  end

  def events
    object.recent_events
  end

  def actions
    object.available_actions
  end

end

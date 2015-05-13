class StorySerializer < ActiveModel::Serializer
  attributes :player, :events, :actions

  def player
    PlayerSerializer.new(object, root: nil)
  end

  def events
    object.new_events.map do |event|
      EventSerializer.new(event, root: nil)
    end
  end

  def actions
    object.available_actions
  end

end

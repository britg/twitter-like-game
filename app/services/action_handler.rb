class ActionHandler

  attr_accessor :player, :event_id, :action_key

  def initialize _player, event_id, action_key
    @player = _player
    @event_id = event_id
    @action_key = action_key
  end

  def perform!
    # temp
    e = player.events.build(detail: Time.now.to_i)
    e.actions << Action.create(label: "Next", key: "next")
    e.save
    e
  end

end
class ActionHandler

  attr_accessor :player, :action_key

  def initialize _player, action_key
    @player = _player
    @action_key = action_key
  end

  def perform!

    @player.events.current.update_all(current_state: "old")

    # temp
    e = player.events.create(detail: Time.now.to_i, current_state: "current")
    e.actions.create(label: "Next", key: "next")
    e.save
    [e]
  end

end
class ActionHandler

  attr_accessor :player

  def initialize _player, action_key
    @player = _player
  end

  def perform!
    # temp
    e = player.events.build(detail: Time.now.to_i)
    e.actions << Action.create(label: "Next", key: "next")
    e.save
    e
  end

end
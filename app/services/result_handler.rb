class ResultHandler

  attr_accessor :player, :story_event

  def initialize _player, _story_event
    @player = _player
    @story_event = _story_event
  end

  def apply
    @player.update_attributes(hp: @player.hp-1)
  end

end
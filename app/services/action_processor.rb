class ActionProcessor

  attr_accessor :player

  def initialize _player
    @player = _player
  end

  def current_event
    @player.current_event
  end

  def explorer
    @explorer ||= ExplorationProcessor.new(@player)
  end

  def process action_slug
    raise Event::InvalidAction unless current_event.valid_action?(action_slug)
    if action_slug.to_sym == :explore
      return explorer.process
    end
  end

end
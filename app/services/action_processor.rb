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

  def battle_processor
    @battle_processor ||= BattleProcessor.new(@player.battle)
  end

  def process action_slug
    raise Event::InvalidAction unless current_event.valid_action?(action_slug)
    # temp
    if action_slug.to_sym == :explore
      return explorer.process
    end

    if action_slug.to_sym == :attack
      return battle_processor.process
    end
  end

end

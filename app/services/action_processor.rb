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

  def observation_processor
    @observation_processor ||= ObservationProcessor.new(@player)
  end

  def find_processor
    @find_processor ||= FindProcessor.new(@player)
  end

  def process action_slug
    raise Event::InvalidAction unless current_event.valid_action?(action_slug)

    # temp implementation

    if action_slug.to_sym == :explore
      return explorer.process
    end

    if action_slug.to_sym == :attack
      return battle_processor.process
    end

    if action_slug.to_sym == :observe
      return observation_processor.process
    end

    if action_slug.to_sym == :find
      return find_processor.process_random
    end

    if action_slug.to_sym == :find_survival
      return find_processor.process_survival
    end

    if action_slug.to_s.match(/find_/)
      resource_slug = action_slug.to_s.split('_').last.to_sym
      return find_processor.process_resource resource_slug
    end

  end

end

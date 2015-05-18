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

  def interaction_creator
    @interaction_creator ||= InteractionCreator.new(@player)
  end

  def interaction_processor
    @interaction_processor ||= InteractionProcessor.new(@player)
  end

  def process action_slug
    raise Event::InvalidAction unless available_action_keys.include?(action_slug.to_s)

    current_event.update_attributes(chosen_action_key: action_slug)

    if action_slug.to_sym == :explore
      return explorer.process
    end

    if action_slug.to_sym == :attack
      return battle_processor.attack_from(@player)
    end

    if action_slug.to_sym == :flee
      return battle_processor.flee(@player)
    end

    if action_slug.to_sym == :avoid
      return battle_processor.avoid(@player)
    end

    if action_slug.to_sym == :battle_observe
      return battle_processor.observe(@player)
    end

    if action_slug.to_sym == :observe
      return observation_processor.create_all_observation_events
    end

    if action_slug.to_sym == :find
      return find_processor.process_random
    end

    if action_slug.to_sym == :find_survival
      return find_processor.process_survival
    end

    if action_slug.to_s.match(/find->/)
      resource_slug = action_slug.to_s.split('->').last.to_sym
      return find_processor.process_resource resource_slug
    end

    # Interacting with a landmark
    if action_slug.to_s.match(/landmark->/)
      landmark_state_slug = action_slug.to_s.split('->').last.to_sym
      return interaction_creator.create(landmark_state_slug)
    end

    if action_slug.to_sym == :leave
      landmark_state_id = action_slug.to_s.split('->').last.to_sym
      interaction_processor.leave
    end

    # Interacting with a resource node
    if action_slug.to_sym == :resource_node_investigate
      ResourceNodeProcessor.new(@player).investigate
    end

    if action_slug.to_sym == :resource_node_ignore
      ResourceNodeProcessor.new(@player).ignore
    end

  end

  def available_actions
    return dead_actions if @player.dead?
    return exploration_actions if @player.exploring?
    return interaction_actions if @player.interacting?
    return battle_actions if @player.in_battle?
    []
  end

  def available_action_keys
    keys = []
    available_actions.each do |action|
      keys << action.key
      action.child_actions.each do |sub_action|
        keys << sub_action.key
      end
    end
    keys
  end

  def exploration_actions
    explorer.available_actions
  end

  # Return set of actions based on the
  # landmark type
  def interaction_actions
    actions = []
    actions << Action.new(label: "Leave", key: :leave)
    actions |= interaction_processor.available_actions
    actions
  end

  def battle_actions
    battle_processor.available_actions_for(@player)
  end

  def dead_actions
    actions = []
    actions << Action.new(label: "Restart", key: :restart)
    actions
  end
end

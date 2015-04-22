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

    # temp implementation

    if action_slug.to_sym == :explore
      return explorer.process
    end

    if action_slug.to_sym == :attack
      return battle_processor.process
    end

    if action_slug.to_sym == :flee
      return battle_processor.flee(@player)
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

  end

  def available_actions
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
    actions = []
    actions << Action.new(label: "Explore", key: :explore)
    # actions << Action.new(label: "Observe", key: :observe)
    find_action = Action.new(label: "Find", key: :find)
    find_action.child_actions.build(label: "Reagents", key: "find->reagents")
    actions << find_action
    landmarks_action = Action.new(label: "Landmarks", key: :landmark)
    @player.current_landmark_states.each do |landmark_state|
      landmarks_action.child_actions.build(label: landmark_state.to_s, key: landmark_state.to_action_key)
    end
    actions << landmarks_action
    actions << Action.new(label: "Craft", key: :craft)
    actions
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
    actions = []
    actions << Action.new(label: "Attack", key: :attack)
    actions << Action.new(label: "Skill", key: :special)
    actions << Action.new(label: "Flee", key: :flee)
    actions
  end
end

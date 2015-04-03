class StoryEngine

  attr_accessor :player

  def initialize _player
    @player = _player
    ensure_context
  end

  def current_event_sequence
    @player.current_event_sequence.to_i
  end

  def ensure_context
    start_index = StoryContext::EVENT_START_INDEX
    if current_event_sequence < start_index
      event = current_context.find_event(start_index)
      apply_story_events(event)
    end
  end

  def current_context_name
    (@player.current_context || configatron.default_context).camelcase
  end

  def current_context
    current_context_name.constantize
  end

  def current_event
    @player.events.last
  end

  def current_story_event
    marker.current_event
  end

  def marker
    @marker ||= current_context.marker(current_event_sequence)
  end

  def has_actions?
    marker.current_event.has_actions?
  end

  def action_required?
    marker.current_event.action_required?
  end

  def action_key_valid? action_key
    marker.current_event.action_valid?(action_key)
  end

  def available_action_keys
    marker.current_event.available_action_keys
  end

  def take_action action_key
    action_key = action_key.to_sym
    raise "Invalid action. Got: #{action_key}, expected #{available_action_keys}" unless action_key_valid?(action_key)
    current_event.update_attributes(chosen_action_key: action_key)
    marker.take_action(action_key)
  end

  def proceed action_key = nil
    story_events = []

    if has_actions?
      raise "Action needed [#{available_action_keys.join(',')}]" if action_key.nil?
      story_events << take_action(action_key)
    end

    while !has_actions?
      story_events << marker.next_event
    end

    mark_old_events
    raise "No new events" unless story_events.any?
    apply_story_events story_events
  end

  def apply_story_events story_events
    story_events = Array(story_events)
    @new_events = []
    story_events.each do |story_event|
      apply_results(story_event)
      @new_events << convert_story_event(story_event)
    end
    @newest_event = @new_events.last
    @newest_event.update_attributes(current_state: "current")
    @player.events << @new_events
    @player.update_attributes(current_event_sequence: @newest_event.sequence)
    @new_events
  end

  def apply_results story_event
    ResultHandler.new(@player, story_event).apply
  end

  def convert_story_event story_event
    e = Event.create(detail: story_event.detail,
                     dialogue: story_event.dialogue,
                     current_state: Event::NEW_STATE,
                     sequence: story_event.sequence)
    story_event.actions.each do |key, story_action|
      e.actions.create(label: story_action[:label], key: key)
    end
    e.save and e
  end

  def mark_old_events
    @player.events.new_and_current.update_all(current_state: "old")
  end

  def reset!
    @player.update_attributes(current_event_sequence: nil,
                              current_context: "intro")
    @player.events.delete_all
  end

end
class ActionHandler

  attr_accessor :player

  def initialize _player
    @player = _player
    ensure_chapter_position
  end

  def current_event_sequence
    @player.current_event_sequence.to_i
  end

  def ensure_chapter_position
    start_index = Tale::Chapter::EVENT_START_INDEX
    if current_event_sequence < start_index
      event = current_chapter.find_event(start_index)
      apply_story_events(event)
    end
  end

  def current_chapter_name
    (@player.current_chapter || Player::DEFAULT_CHAPTER).camelcase
  end

  def current_chapter
    current_chapter_name.constantize
  end

  def current_event
    @player.events.last
  end

  def current_story_event
    hero.current_event
  end

  def hero
    @hero ||= current_chapter.hero(current_event_sequence)
  end

  def has_actions?
    hero.current_event.has_actions?
  end

  def action_required?
    hero.current_event.action_required?
  end

  def action_key_valid? action_key
    hero.current_event.action_valid?(action_key)
  end

  def available_action_keys
    hero.current_event.available_action_keys
  end

  def take_action action_key
    action_key = action_key.to_sym
    raise "Invalid action. Got: #{action_key}, expected #{available_action_keys}" unless action_key_valid?(action_key)
    current_event.update_attributes(chosen_action_key: action_key)
    hero.take_action(action_key)
  end

  def proceed action_key = nil
    story_events = []

    if has_actions?
      raise "Action needed [#{available_action_keys.join(',')}]" if action_key.nil?
      story_events << take_action(action_key)
    end

    while !has_actions?
      story_events << hero.next_event
    end

    mark_old_events
    raise "No new events" unless story_events.any?
    apply_story_events story_events
  end

  def apply_story_events story_events
    story_events = Array(story_events)
    @new_events = []
    story_events.each do |story_event|
      @new_events << convert_story_event(story_event)
    end
    @newest_event = @new_events.last
    @newest_event.update_attributes(current_state: "current")
    @player.events << @new_events
    @player.update_attributes(current_event_sequence: @newest_event.sequence)
    @new_events
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
                              current_chapter: "intro")
    @player.events.delete_all
  end

end
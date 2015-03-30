class ActionHandler

  attr_accessor :player

  def initialize _player
    @player = _player
  end

  def current_event
    @player.events.last
  end

  def needs_action?
    return false unless current_event.present?
    current_event.actions.any?
  end

  def valid_action_keys
    return [] unless current_event.present?
    current_event.actions.map(&:key)
  end

  def action_key_valid? action_key
    action_key.present? && valid_action_keys.include?(action_key)
  end

  def proceed! action_key = nil
    if needs_action?
      return false unless action_key_valid?(action_key)
      take_action(action_key)
    end

    mark_old_events
    story_events = current_chapter.next_event_group
    return false unless story_events.any?

    @new_events = []
    story_events.each do |story_event|
      @new_events << convert_story_event(story_event)
    end
    @newest_event = @new_events.last
    @newest_event.update_attributes(current_state: "current")
    @player.events << @new_events
    @player.update_attributes(current_event_sequence: @newest_event.sequence)
  end

  def convert_story_event story_event
    e = Event.create(detail: story_event.detail,
                     dialogue: story_event.dialogue,
                     current_state: Event::NEW_STATE,
                     sequence: story_event.sequence)
    story_event.actions.each do |story_action|
      e.actions.create(label: story_action[:label], key: story_action[:key])
    end
    e.save and e
  end

  def mark_old_events
    @player.events.new_and_current.update_all(current_state: "old")
  end

  def take_action action_key
    return false unless action_key_valid?(action_key)
    current_event.update_attributes(chosen_action_key: action_key)
    current_chapter.choose!(action_key)
  end

  def current_chapter
    # @chapter ||= Intro.new(@player.current_event_sequence)
    @chapter ||= BranchTest.new(@player.current_event_sequence)
  end

  def reset!
    @player.update_attributes(current_event_sequence: nil)
    @player.events.delete_all
    @chapter = nil
  end

end
class ActionHandler

  attr_accessor :player

  def initialize _player
    @player = _player
  end

  def take_action! action_key

  end

  def proceed!
    @player.events.current.update_all(current_state: "old")
    story_events = current_chapter.next_event_group

    story_events.each do |story_event|
      convert_story_event(story_event)
    end
    @last_event = @player.events.last
    @last_event.update_attributes(current_state: "current")
    @player.update_attributes(current_event_sequence: @last_event.sequence)
  end

  def convert_story_event story_event
    e = @player.events.create(detail: story_event.detail,
                             dialogue: story_event.dialogue,
                             current_state: Event::NEW_STATE,
                             sequence: story_event.sequence)
    story_event.actions.each do |story_action|
      e.actions.create(label: story_action[:label], key: story_action[:key])
    end
    e.save
  end

  def convert_event_action

  end

  def current_chapter
    @chapter ||= Intro.new(@player.current_event_sequence)
  end

  def reset!
    @player.update_attributes(current_event_sequence: nil)
    @player.events.delete_all
    @chapter = nil
  end

end
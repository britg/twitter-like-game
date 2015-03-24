class ActionHandler

  attr_accessor :player, :action_key

  def initialize _player, action_key = nil
    @player = _player
    @action_key = action_key
  end

  def proceed!
    @player.events.current.update_all(current_state: "old")
    story_events = current_chapter.next_event_group

    story_events.each do |story_event|
      convert_story_event(story_event)
    end
    @player.events.last.update_attributes(current_state: "current")
  end

  def convert_story_event story_event
    e = @player.events.create(detail: story_event.detail,
                             dialogue: story_event.dialogue,
                             current_state: Event::NEW_STATE)
    story_event.actions.each do |story_action|
      e.actions.create(label: story_action[:label], key: story_action[:key])
    end
    e.save
  end

  def convert_event_action

  end

  def current_chapter
    @chapter ||= Intro.new(@player)
  end

end
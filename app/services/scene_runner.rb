class SceneRunner

  attr_accessor :player

  def self.scene slug
    slug.to_s.camelcase.constantize
  end

  def initialize _player
    @player = _player
    raise "Currently in a battle!" if @player.in_battle?
    ensure_scene
    ensure_location
  end

  def current_event_sequence
    @player.current_event_sequence.to_i
  end

  def ensure_scene
    start_index = Scene::EVENT_START_INDEX
    if current_event_sequence < start_index
      event = current_scene.find_event(start_index)
      apply_event_templates(event)
    end
  end

  def ensure_location
    if current_scene.location.present?
      @player.update_attributes(current_location_slug: current_scene.location.slug)
    end
  end

  def current_scene
    SceneRunner.scene(@player.current_scene)
  end

  def current_event
    @player.events.last
  end

  def current_event_template
    marker.current_event
  end

  def marker
    @marker ||= current_scene.marker(current_event_sequence)
  end

  def has_actions?
    marker.current_event_template.has_actions?
  end

  def stops_flow?
    marker.current_event_template.stops_flow?
  end

  def action_required?
    marker.current_event_template.action_required?
  end

  def action_key_valid? action_key
    marker.current_event_template.action_valid?(action_key)
  end

  def available_action_keys
    marker.current_event_template.available_action_keys
  end

  def take_action action_key
    action_key = action_key.to_sym
    raise "Invalid action. Got: #{action_key}, expected #{available_action_keys}" unless action_key_valid?(action_key)
    current_event.update_attributes(chosen_action_key: action_key)
    marker.take_action(action_key)
  end

  def proceed action_key = nil
    event_templates = []

    if has_actions?
      raise "Action needed [#{available_action_keys.join(',')}]" if action_key.nil?
      event_template_or_scene_change = take_action(action_key)
      if event_template_or_scene_change.class == EventTemplate
        event_template = event_template_or_scene_change
      else
        scene_change = event_template_or_scene_change
        return change_scenes(scene_change)
      end
      event_templates << event_template
    end

    while !stops_flow?
      event_templates << marker.next_event
    end

    mark_old_events
    raise "No new events" unless event_templates.any?
    apply_event_templates event_templates
  end

  def apply_event_templates event_templates
    event_templates = Array(event_templates)
    @new_events = []
    event_templates.each do |event_template|
      apply_results(event_template)
      @new_events << convert_event_template(event_template)
    end
    @newest_event = @new_events.last
    @newest_event.update_attributes(current_state: "current")
    @player.events << @new_events
    @player.update_attributes(current_event_sequence: @newest_event.sequence)
    @new_events
  end

  def apply_results event_template
    ResultHandler.new(@player, event_template).apply
  end

  def convert_event_template event_template
    e = Event.create(detail: event_template.detail,
                     dialogue: event_template.dialogue,
                     current_state: Event::NEW_STATE,
                     sequence: event_template.sequence)
    event_template.actions.each do |key, story_action|
      e.actions.create(label: story_action[:label], key: key)
    end
    e.save and e
  end

  def mark_old_events
    @player.events.new_and_current.update_all(current_state: "old")
  end

  def change_scenes scene_change
    puts "Changing scenes #{scene_change}"
    if scene_change.to_battle?
      return BattleCreator.new(@player, scene_change.battle_template).create
    end
  end

  def reset!
    @player.update_attributes(current_event_sequence: nil,
                              current_scene: "intro")
    @player.events.delete_all
  end

end
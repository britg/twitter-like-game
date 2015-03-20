class EventEngine

  attr_accessor :player

  def initialize _player
    @player = _player
  end

  def current_location
    @player.current_location.location
  end

  def current_event
    @player.events.last
  end

  def current_event_marker
    current_event.try(:marker) || 0
  end

  def next_event_template
    current_location.event_templates.gt(order: current_event_marker).first
  end

  def converter
    EventTemplateConverter.new(@player, next_event_template)
  end

  def next!
    return false unless next_event_template.present?
    @event = converter.build
    @event.try(:save)
  end

end
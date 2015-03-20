class EventTemplateConverter

  attr_accessor :player, :template

  def initialize _player, _event_template
    @player = _player
    @template = _event_template
  end

  def build
    @event = @player.events.build(
      character: template.character,
      marker: template.order,
      detail: template.detail,
      dialogue: template.dialogue
    )
  end

end
class EventTemplateConverter

  attr_accessor :player, :template

  def initialize _player, _event_template
    @player = _player
    @template = _event_template
  end

  def build
    @event = @player.events.build(
      character_name: template.character.try(:name),
      detail: template.detail,
      dialogue: template.dialogue,

      scripted_event_id: template.scripted_event.id,
      event_template_id: template.id,
      location_id: template.scripted_event.location.id,

      actions: template.actions,
      created_at: Time.now
    )
  end

end
class InteractionProcessor

  def initialize _player
    @player = _player
    @landmark = @player.landmark
  end

  def available_actions
    []
  end

  def leave
    @player.update_attributes(landmark_id: nil)
    @player.add_event(
      detail: "You leave #{@landmark.to_s}..."
    )
  end

end

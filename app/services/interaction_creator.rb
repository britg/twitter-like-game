class InteractionCreator

  def initialize _player
    @player = _player
  end

  def create landmark_state_id
    @landmark_state = @player.current_landmark_states.find(landmark_state_id.to_s)
    raise "Landmark state not found" unless @landmark_state.present?
    @landmark = @landmark_state.landmark
    @player.update_attributes(landmark_id: @landmark.id)
    @player.add_event(
      detail: @landmark.start_interaction_detail
    )
  end

end

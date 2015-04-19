class InteractionCreator

  def initialize _player
    @player = _player
  end

  def create landmark_state_slug
    @landmark_state = @player.current_landmark_states.where(slug: landmark_state_slug.to_s).first
    raise "Landmark state not found" unless @landmark_state.present?
    @landmark = @landmark_state.landmark

    if @landmark.location?
      # It's a transition to another location
      LocationProcessor.new(@player, @landmark.obj).enter
      return
    end

    @player.update_attributes(landmark_id: @landmark.id)
    @player.add_event(
      detail: @landmark.start_interaction_detail
    )
  end

end

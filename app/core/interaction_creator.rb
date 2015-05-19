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
    else
      # TODO do something here for non-location landmarks? Or delegate to whatever is handling the interaction.
    end

    @player.update_attributes(landmark_id: @landmark.id)
  end

end

class ExplorationProcessor

  class NoLocationDefined < Exception; end

  attr_accessor :player

  def initialize _player
    @player = _player
    ensure_location
  end

  def ensure_location
    raise NoLocationDefined if !@player.location.present?
    @player.create_exploration_state unless @player.exploration_state.present?
  end

  def exploration_state
    @player.exploration_state
  end

  def delta_time
    Time.now - exploration_state.last_event_time
  end

  def tick
  end

end
class ExplorationAggroResolver

  def initialize _npc, _player
    @npc = _npc
    @player = _player
  end

  def starts_battle?
    false
  end

end

class BattleRunner

  attr_accessor :player, :battle

  def initialize _player
    @player = _player
    @battle = @player.battle
  end

  def proceed action = nil

  end

end
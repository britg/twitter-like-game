class BattleCreator

  # Made up of players and npcs
  def initialize players, npcs
    @players = Array(players)
    @npcs = Array(npcs)
  end

  def create
    @battle = Battle.create(players: @players, npcs: @npcs)
    @players.each do |player|
      player.update_attributes(battle: @battle)
    end
    set_ticks
    @battle
  end

  def set_ticks
    sum = 0
    @battle.participants.each do |participant|
      sum += participant.ap.value
      participant.agent.update_attributes(current_battle_tick: 0,
        current_initiative: 0)
    end
    @battle.update_attributes(combined_initiative: sum)
  end

end

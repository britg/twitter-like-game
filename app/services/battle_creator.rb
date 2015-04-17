class BattleCreator

  def initialize participant_objs
    @battle = Battle.create
    create_participants(participant_objs)
  end

  def create_participants objs
    objs.each do |obj|
      if obj.class == Player
        player = obj
        @battle.participants.create(player: player)
        player.update_attributes(battle: @battle)
      else
        @battle.participants.create(npc: obj, agent: obj.agent)
      end
    end
  end

end

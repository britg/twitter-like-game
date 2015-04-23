class BattleCreator

  def initialize participant_objs
    @participant_objs = participant_objs
  end

  def create
    @battle = Battle.create
    create_participants(@participant_objs)
    @battle
  end

  def create_participants objs
    objs.each do |obj|
      if obj.class == Player
        player = obj
        @battle.participants.create(player: player)
        player.update_attributes(battle: @battle)
      else #obj.class == Npc
        @battle.participants.create(npc: obj, agent: obj.agent)
      end
    end
  end

end

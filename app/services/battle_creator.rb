class BattleCreator

  def initialize participant_objs
    @participant_objs = participant_objs
  end

  def create
    @battle = Battle.create
    create_participants(@participant_objs)
    set_initiative_mark
    @battle
  end

  # Objs can be Player or Npc
  def create_participants objs
    objs.each do |obj|
      if obj.class == Player
        player = obj
        @battle.participants.create(player: player)
        player.update_attributes(battle: @battle)
      else #obj.class == Npc
        @battle.participants.create(npc: obj, agent_instance: obj.agent)
      end
    end
  end

  def set_initiative_mark
    sum = 0
    @battle.participants.each do |participant|
      sum += participant.ap.value
    end
    @battle.update_attributes(combined_initiative: sum)
  end

end

class BattleProcessor

  attr_accessor :battle

  def initialize participant_objs = []
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

  def participant_names
    @names ||= @battle.participants.map(&:to_s)
  end

  def start
    @battle.players.each do |p|
      p.battle_event(
        detail: "Battle has started between #{participant_names.to_sentence}"
      )
    end

    # determine_initiative
    #
  end

  def process
    debug "processing battle"

  end

end
class BattleCreator

  attr_accessor :player, :battle_template

  def initialize _player, _battle_template
    @player = _player
    @battle_template = _battle_template
  end

  def create
    puts "Creating battle with #{@player} #{@battle_template}"
    raise "Player already in a battle" if @player.in_battle?
    b = Battle.create
    b.participants.create(player: @player)
    @battle_template.participants.each do |slug|
      instance_participant(b, slug)
    end
    b.save
    @player.update_attributes(battle: b)
    b
  end

  def instance_participant battle, npc_slug
    npc = Npc.where(slug: npc_slug.to_sym).first
    battle.participants.create(
      npc: npc,
      agent: npc.agent
    )
  end

end
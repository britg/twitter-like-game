class BattleCreator

  attr_accessor :player, :battle_template

  def initialize _player, _battle_template
    @player = _player
    @battle_template = _battle_template
  end

  def create
    puts "Creating battle with #{@player} #{@battle_template}"
    raise "Player already in a battle" if @player.in_battle?
    b = Battle.new return_scene: @battle_template.return_scene,
                   return_waypoint: @battle_template.return_waypoint
    @battle_template.agents.each do |enemy|
      instance_enemy(b, enemy)
    end
    b.save
    @player.update_attributes(battle: b)
    b
  end

  def instance_enemy battle, enemy_agent_slug
    enemy_agent = Agent.where(slug: enemy_agent_slug.to_sym).first
    battle_enemy = enemy_agent.attributes
    battle.enemies << battle_enemy
  end

end
class Battle
  include Mongoid::Document

  has_many :players

  field :enemies, type: Array, default: []
  field :return_scene, type: String
  field :return_waypoint, type: String

  def proceed player, action = nil
    @battle_runner ||= BattleRunner.new(player)
    @battle_runner.proceed action
  end

end

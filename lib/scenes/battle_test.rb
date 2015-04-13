class BattleTest < Scene
  event waypoint: "start-battle" do
    detail "Starting battle"
    action :battle, label: "Enter Battle"
    battle agents: [:large_man], return_to: {scene: :meet_ranger, waypoint: "large-man-tamed"}
  end
end
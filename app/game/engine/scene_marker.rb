class SceneMarker
  attr_accessor :scene,
                :current_sequence

  def initialize _scene, _sequence = 1
    @scene = _scene
    @current_sequence = _sequence
    @current_event_template = @scene.find_event(@current_sequence)
  end

  def current_branch
    @scene.branches[@current_event_template.branch_name]
  end

  def current_event_template
    event = current_branch.seq(@current_sequence)
    @current_sequence = event.sequence
    event
  end

  def take_action key
    raise "No action available" unless current_event_template.has_actions?

    branch_name = key.to_sym
    raise "Invalid action" unless current_event_template.action_valid?(branch_name)

    if current_event_template.starts_battle?
      change_scene_to_battle
    elsif @scene.branch_exists? branch_name
      change_branches_to branch_name
    else
      next_event
    end
  end

  def change_scene_to_battle
    @scene_change = SceneChange.new
    @scene_change.scene_slug = :battle
    @scene_change.battle_template = BattleTemplate.new(current_event_template.battle)
    @scene_change
  end

  def change_branches_to branch_name
    @current_event_template = @scene.branches[branch_name].seq(@current_event_template.sequence)
  end

  def next_event
    raise "Action required" if current_event_template.action_required?
    event_or_exit = current_branch.seq(@current_sequence + 1)
    if event_or_exit.class == Symbol
      exit_branch = event_or_exit
      @current_event_template = @scene.branches[exit_branch].seq(@current_sequence+1)
    else
      @current_event_template = event_or_exit
    end
    @current_sequence = @current_event_template.sequence
    @current_event_template
  end
end
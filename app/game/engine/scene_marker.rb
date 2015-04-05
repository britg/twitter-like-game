class SceneMarker
  attr_accessor :context,
                :current_sequence

  def initialize _context, _sequence = 1
    @context = _context
    @current_sequence = _sequence
    @current_event_template = @context.find_event(@current_sequence)
  end

  def current_branch
    @context.branches[@current_event_template.branch_name]
  end

  def current_event_template
    event = current_branch.seq(@current_sequence)
    @current_sequence = event.sequence
    event
  end

  def next_event
    raise "Action required" if current_event_template.action_required?
    event_or_exit = current_branch.seq(@current_sequence + 1)
    if event_or_exit.class == Symbol
      exit_branch = event_or_exit
      @current_event_template = @context.branches[exit_branch].seq(@current_sequence+1)
    else
      @current_event_template = event_or_exit
    end
    @current_sequence = @current_event_template.sequence
    @current_event_template
  end

  def take_action key
    raise "No action available" unless current_event_template.has_actions?

    branch_name = key.to_sym
    raise "Invalid action" unless current_event_template.action_valid?(branch_name)

    if @context.branch_exists? branch_name
      @current_event_template = @context.branches[branch_name].seq(@current_event_template.sequence)
    else
      next_event
    end
  end
end
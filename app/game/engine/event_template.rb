class EventTemplate
  attr_accessor :opts,
                :sequence,
                :detail,
                :dialogue,
                :agent_name,
                :actions,
                :results,
                :branch_name,
                :transition

  def initialize _opts
    @opts = _opts
    @sequence = @opts[:sequence]
    @branch_name = @opts[:branch_name]
    @actions = {}
    @results = {}
  end

  def no_actions?
    @actions.empty?
  end

  def has_actions?
    @actions.any?
  end

  def action_required?
    @actions.count > 1
  end

  def action_valid? key
    @actions[key].present?
  end

  def available_action_keys
    @actions.keys
  end

  def has_results?
    @results.any?
  end
end
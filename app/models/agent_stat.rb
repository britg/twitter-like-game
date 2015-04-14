class AgentStat
  include Mongoid::Document

  embedded_in :agent

  belongs_to :stat
  delegate :slug, to: :stat
  field :base_value, type: Integer

  def derived_value
    # Do the calculation here
    stat.calculator.new(agent, base_value).result
  end
  alias_method :value, :derived_value

end
class AgentStat
  include Mongoid::Document

  embedded_in :agent
  field :base_value, type: Integer, default: -> { stat.base_value }
  field :current_offset, type: Integer, default: 0
  field :slug, type: String

  def stat
    @stat ||= Stat.slug(slug)
  end

  def derived_value
    stat.calculator.new(agent, base_value).result rescue base_value
  end
  alias_method :max_value, :derived_value

  def value
    derived_value + current_offset
  end

end

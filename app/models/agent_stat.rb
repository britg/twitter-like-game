class AgentStat
  include Mongoid::Document

  embedded_in :agent
  field :base_value, type: Integer, default: 10
  field :slug, type: String

  def stat
    Stat.slug(slug)
  end

  def derived_value
    stat.calculator.new(agent, base_value).result
  end
  alias_method :value, :derived_value

end
module Calculator
  extend ActiveSupport::Concern

  def initialize _agent, _base_value
    @agent = _agent
    @base_value = _base_value
  end

  def result
    @base_value
  end

  def item_additions_for_stat stat
    0
  end

end

class StrengthCalculator
  include ItemBasedCalculator

  attr_accessor :agent

  def initialize _agent, _base_value
    @agent = _agent
    @base_value = _base_value
  end

  def result
    @base_value + item_additions_for_stat(:str)
  end

end
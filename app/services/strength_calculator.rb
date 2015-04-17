class StrengthCalculator
  include Calculator

  def result
    @base_value + item_additions_for_stat(:str)
  end

end

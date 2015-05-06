module HasCalculator
  extend ActiveSupport::Concern

  included do
    field :calculator_type, type: String, default: "PassthroughCalculator"
  end

  def calculator_class
    calculator_type.constantize
  end

  def calculator
    calculator_class rescue PassthroughCalculator
  end

end

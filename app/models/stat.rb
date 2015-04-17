class Stat
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  field :calculator_class, type: String

  def calculator
    calculator_class.constantize rescue Calculator
  end

end
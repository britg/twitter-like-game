class Skill
  include Mongoid::Document
  include HasSlug

  class InvalidSkill < Exception; end

  field :name, type: String
  field :group, type: String

  def calculator_class
    "#{slug.camelcase}Calculator"
  end

  def calculator
    calculator_class.constantize rescue PassthroughCalculator
  end

end

class Skill
  include Mongoid::Document
  include HasSlug

  class InvalidSkill < Exception; end

  field :name, type: String
  field :group, type: String
  field :calculator_class, type: String

  def calculator
    calculator_class.constantize rescue Calculator
  end

end
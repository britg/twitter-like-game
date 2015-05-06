class Skill
  include Mongoid::Document
  include HasSlug
  include HasCalculator

  class InvalidSkill < Exception; end

  field :name, type: String
  field :group, type: String

end

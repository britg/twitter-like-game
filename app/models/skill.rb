class Skill
  include Mongoid::Document
  include HasSlug

  class InvalidSkill < Exception; end

  field :name, type: String
  field :group, type: String

end
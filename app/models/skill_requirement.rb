class SkillRequirement
  include Mongoid::Document

  belongs_to :skill

  embedded_in :landmark

  field :range, type: Range, default: 0..100

end
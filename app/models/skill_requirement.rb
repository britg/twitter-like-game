class SkillRequirement
  include Mongoid::Document

  belongs_to :skill
  belongs_to :stat

  embedded_in :landmark
  embedded_in :resource

  field :range, type: Range, default: 0..100

end

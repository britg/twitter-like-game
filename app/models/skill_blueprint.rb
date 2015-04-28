class SkillBlueprint
  include Mongoid::Document

  embedded_in :npc_blueprint

  field :slug, type: String
  field :range, type: Range

  def skill
    Skill.slug(slug)
  end

end

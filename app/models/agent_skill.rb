class AgentSkill
  include Mongoid::Document

  embedded_in :agent
  field :base_value, type: Float, default: 0
  field :slug, type: String

  def self.value_for_skill skill
    where(skill: skill).first.try(:value)
  end

  def skill
    Skill.slug(slug)
  end

  def derived_value
    skill.calculator.new(agent, base_value).result
  end

  def value
    derived_value.round(1)
  end

end
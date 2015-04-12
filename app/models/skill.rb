class Skill
  include Mongoid::Document

  GROUPS = {
    basic: [
      :perception
    ]
  }

  field :name, type: String
  field :slug, type: String
  field :value, type: Float
  field :group, type: String

  embedded_in :player

  def self.skills
    GROUPS.values.flatten
  end

  def self.group slug
    GROUPS.each do |g, list|
      return g if list.include?(slug.to_sym)
    end
  end

  def self.valid? slug
    skills.include?(slug.to_sym)
  end

end
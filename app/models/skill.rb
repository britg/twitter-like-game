class Skill
  include Mongoid::Document

  class InvalidSkill < Exception; end

  field :name, type: String
  field :slug, type: String
  index({slug: 1}, {unique: true})

  field :group, type: String

  def self.valid? slug
    where(slug: slug).present?
  end

  def self.create_from_slug slug

  end

end
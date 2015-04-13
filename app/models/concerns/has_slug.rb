module HasSlug
  extend ActiveSupport::Concern

  included do
    field :slug, type: String
    index({slug: 1}, {unique: true})
  end

  class_methods do
    def slug s
      where(slug: s).first
    end
  end

end
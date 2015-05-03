class ObjectBuild
  def initialize hash
    @hash = hash
  end

  def slug
    @hash["slug"]
  end

  def type
    @hash["type"].constantize
  end

  def existing
    type.where(slug: slug).first
  end

  def create_or_update
    return update if existing.preset?
    create
  end

  def build_dependency obj_type, slug
    Build.new.update_slug(obj_type, slug)
  end

end

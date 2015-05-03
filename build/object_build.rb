class ObjectBuild
  def initialize hash, build
    @hash = hash
    @build = build
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
    return update if existing.present?
    create
  end

  def build_dependency obj_type, slug
    puts "Building dependency #{obj_type} #{slug}"
    @build.ensure_existence(obj_type, slug)
  end

  def create
    puts "#{self.class} needs a create implementation"
  end

  def update
    puts "#{self.class} needs an update implementation"
  end

end

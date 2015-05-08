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
    if existing.present?
      puts "#{type} #{slug} exists, so updating"
      update
      return existing
    end
    puts "#{type} #{slug} not found, so creating"
    create
  end

  def build_dependency obj_type, slug
    puts "Building dependency #{obj_type} #{slug}"
    @build.ensure_existence(obj_type, slug)
  end

  def props
    @hash.except("type")
  end

  def create
    @obj = type.create(props)
    update
  end

  def update
    @obj ||= existing
    @obj.update_attributes(props)
    @obj
  end

  def method_missing method, *args
    if method.match(/associate_/)
      do_association(method)
    end
  end

  def do_association method_name
    name = method_name.to_s.gsub("associate_", '')
    type = name.camelcase
    assoc = build_dependency(type, @hash[name])
    existing.update_attributes("#{name}" => assoc)
  end

end

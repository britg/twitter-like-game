class Build

  attr_accessor :hashes

  RESOURCE_TYPES = ["locations", "npc_blueprints", "resources",
    "combat_profiles"]

  def initialize
    @hashes = []
  end

  def load_all
    RESOURCE_TYPES.each do |t|
      load_json(t)
    end
  end

  def load_json type
    @hashes ||= {}
    return if @hash[type].present?
    @hashes[type] = []
    Dir["#{Rails.root}/build/#{type}/**/*.json"].each do |file|
      content = open(file){ |f| f.read }
      hash = JSON.parse(content.to_s)
      @hashes[type] << hash
    end
  end

  def fresh

  end

  def update_all
    RESOURCE_TYPES.each do |t|
      update_type(t)
    end
  end

  def update_type type
    load_json(type)
    @hashes[type].each do |hash|
      create_or_update(hash)
    end
  end

  def update_slug type, slug
    load_json(type)
    @hashes[type].each do |hash|
      create_or_update(hash) if hash["slug"] == slug
    end
  end

  def create_or_update hash
    type = hash["type"]
    builder = "#{type}Build"
    klass = builder.constantize
    inst = klass.new(hash)
    inst.create_or_update
  end

end

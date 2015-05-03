require "#{Rails.root}/build/object_build"
Dir["#{Rails.root}/build/**/*.rb"].each {|file| require file }

class Build

  attr_accessor :hashes

  RESOURCE_TYPES = ["Location", "NpcBlueprint", "Resource",
    "CombatProfile"]

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
    return if @hashes[type].present?
    @hashes[type] = []
    dir = type.underscore.pluralize
    Dir["#{Rails.root}/build/#{dir}/**/*.json"].each do |file|
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

  def ensure_existence type, slug
    existing = type.constantize.where(slug: slug).first
    return existing if existing.present?
    load_json(type)
    found = nil
    @hashes[type].each do |hash|
      found = hash and break if hash["slug"] == slug
    end

    if found.present?
      create_or_update(found)
    else
      raise "Dependency not found #{type} #{slug}"
    end

  end

  def create_or_update hash
    type = hash["type"]
    builder = "#{type}Build"
    klass = builder.constantize
    inst = klass.new(hash, self)
    inst.create_or_update
  end

end

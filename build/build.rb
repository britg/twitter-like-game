require "#{Rails.root}/build/object_build"
Dir["#{Rails.root}/build/**/*.rb"].each {|file| require file }

class Build

  attr_accessor :hashes

  RESOURCE_TYPES = [
    "Skill",
    "Stat",
    "Resource",
    "CombatProfile",
    "NpcBlueprint",
    "Location",
    "Character"
  ]

  def self.whipe!
    RESOURCE_TYPES.each do |t|
      t.constantize.delete_all
    end
    Player.delete_all
    User.delete_all
    Battle.delete_all
  end

  def initialize
    @hashes = {}
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
    puts "Updating all"
    RESOURCE_TYPES.each do |t|
      update_type(t)
    end
  end

  def update_type type
    puts "Loading #{type}"
    load_json(type)
    @hashes[type].each do |hash|
      create_or_update(hash)
    end
  end

  def ensure_existence type, slug
    existing = type.constantize.where(slug: slug).first
    if existing.present?
      puts "#{type} #{slug} already exists"
      return existing
    end
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
    raise "No type defined" if type.empty?
    builder = "#{type}Build"
    klass = builder.constantize
    inst = klass.new(hash, self)
    inst.create_or_update
  end

end

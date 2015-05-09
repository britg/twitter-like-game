require "#{Rails.root}/build/object_build"
Dir["#{Rails.root}/build/**/*.rb"].each {|file| require file }

class Build

  attr_accessor :hashes

  RESOURCE_TYPES = [
    "Rarity",
    "Skill",
    "Stat",
    "Slot",
    "Resource",
    "EquipmentBlueprint",
    "ConsumableBlueprint",
    "VendorItemBlueprint",
    "CombatProfile",
    "NpcBlueprint",
    "Location",
    "Character"
  ]

  def self.whipe!
    Rarity.collection.drop
    Player.collection.drop
    LocationState.collection.drop
    Event.collection.drop
    User.collection.drop
    Battle.collection.drop
    Character.collection.drop
    CombatProfile.collection.drop
    Location.collection.drop
    NpcBlueprint.collection.drop
    Npc.collection.drop
    Resource.collection.drop
    Skill.collection.drop
    Slot.collection.drop
    Stat.collection.drop
    EquipmentBlueprint.collection.drop
    Equipment.collection.drop
    ConsumableBlueprint.collection.drop
    Consumable.collection.drop
    VendorItemBlueprint.collection.drop
    VendorItem.collection.drop
    ::Mongoid::Tasks::Database.create_indexes
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
    klass = builder.constantize rescue ObjectBuild
    inst = klass.new(hash, self)
    inst.create_or_update
  end

end

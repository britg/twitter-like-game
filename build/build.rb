require "#{Rails.root}/build/object_build"
Dir["#{Rails.root}/build/**/*.rb"].each {|file| require file }

class Build

  attr_accessor :hashes

  RESOURCE_TYPES = [
    "Rarity",
    "Skill",
    "Stat",
    "Slot",
    "Level",
    "Resource",
    "EquipmentBlueprint",
    "ConsumableBlueprint",
    "VendorItemBlueprint",
    "QuestItemBlueprint",
    "CombatProfile",
    "NpcBlueprint",
    "Zone",
    "Location",
    "Character",
    "Quest",
  ]

  def self.whipe!
    Level.collection.drop
    Rarity.collection.drop
    Player.collection.drop
    LocationState.collection.drop
    Event.collection.drop
    User.collection.drop
    Battle.collection.drop
    Character.collection.drop
    CombatProfile.collection.drop
    Zone.collection.drop
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
    Quest.collection.drop
    QuestItemBlueprint.collection.drop
    QuestItem.collection.drop
    BestiaryState.collection.drop
    ::Mongoid::Tasks::Database.create_indexes
  end

  def initialize
    @cache = {}
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
    existing = type.constantize.slug(slug)
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

  def already_touched_this_build? hash
    @cache[hash["type"]] ||= []
    @cache[hash["type"]].include?(hash["slug"])
  end

  def create_or_update hash
    type = hash["type"]
    slug = hash["slug"]
    raise "No type defined" if type.empty?
    raise "No slug defined" if slug.empty?
    if already_touched_this_build?(hash)
      puts "X already touched this build #{type} #{slug}"
      return
    end
    builder = "#{type}Build"
    klass = builder.constantize rescue ObjectBuild
    inst = klass.new(hash, self)
    @cache[type] ||= []
    @cache[type] << hash["slug"]
    inst.create_or_update
  end

end

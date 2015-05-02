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
    @hashes[type] ||= []
    Dir["#{Rails.root}/build/#{type}/**/*.json"].each do |file|
      content = open(file){ |f| f.read }
      hash = JSON.parse(content.to_s)
      @hashes[type] << hash
    end
  end

end

class PlayerCreator

  attr_accessor :player

  def create
    create_player
    assign_default_skills
    set_default_location
    @player.save and @player
  end

  def create_player
    @player = Player.create
  end

  def assign_default_skills
    @default_skills = configatron.player_skills.to_h
    @default_skills.each do |slug, value|
      puts "#{slug} #{value}"
      next unless Skill.valid?(slug)
      @player.skills.create(slug: slug, value: value)
    end
  end

  def set_default_location
    @location = Location.where(slug: configatron.location).first
    LocationProcessor.new(@player, @location).enter
  end

end
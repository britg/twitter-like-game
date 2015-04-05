class ResultHandler

  attr_accessor :player, :story_event

  def initialize _player, _story_event
    @player = _player
    @story_event = _story_event
  end

  def apply
    @story_event.results.each do |type, list|
      send(type, list)
    end
  end

  def ability list
    list.each do |ability_hash|
      slug, metadata = ability_hash.first
      ability = Ability.where(slug: slug).first || raise "Ability #{slug} not found."
      AbilityHandler.new(@player, ability, metadata).apply
    end
  end

end
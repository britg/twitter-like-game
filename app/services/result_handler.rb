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
    list.each do |ability|
      puts "#{ability} applied"
    end
  end

end
class Map
  include Mongoid::Document

  attr_accessor :discoveries, :can_travel

  def index_for_zone zone
    discoveries.each_with_index do |discovery, i|
      return i if discovery[:slug] == zone.slug
    end

    discoveries << new_discovery(zone)
    return discoveries.count - 1
  end

  def new_discovery zone
    {
      slug: zone.slug,
      zone: ZoneSerializer.new(zone, root: nil),
      locations: []
    }
  end

  def can_travel?
    !!@can_travel
  end

end

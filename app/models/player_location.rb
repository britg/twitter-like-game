class PlayerLocation
  include Mongoid::Document

  belongs_to :player
  belongs_to :location

  def url
    location.slug
  end

  def name
    location.name
  end

end

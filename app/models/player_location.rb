class PlayerLocation
  include Mongoid::Document

  belongs_to :player
  belongs_to :location

end

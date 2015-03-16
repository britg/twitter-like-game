class PlayerLocation
  include Mongoid::Document

  embeds_many :events

  belongs_to :player
  belongs_to :location

end

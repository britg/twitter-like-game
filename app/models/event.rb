class Event
  include Mongoid::Document

  embedded_in :player_location

  field :character, type: String
  field :detail, type: String
  field :dialogue, type: String

end

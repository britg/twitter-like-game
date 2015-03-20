class Event
  include Mongoid::Document

  belongs_to :player
  belongs_to :character
  belongs_to :event_template

  field :marker, type: Integer
  field :detail, type: String
  field :dialogue, type: String

end

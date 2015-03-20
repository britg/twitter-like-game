class EventTemplate
  include Mongoid::Document

  embedded_in :location

  belongs_to :character

  field :order, type: Integer
  field :detail, type: String
  field :dialogue, type: String

end

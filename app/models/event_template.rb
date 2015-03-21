class EventTemplate
  include Mongoid::Document

  embedded_in :scripted_event

  belongs_to :character

  field :order, type: Integer
  field :detail, type: String
  field :dialogue, type: String
  field :actions, type: Hash

end

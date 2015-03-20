class ScriptedEvent
  include Mongoid::Document

  embedded_in :location
  embeds_many :event_templates

  field :order, type: Integer
  field :name, type: String
  field :mode, type: String # Player::MODE_ACTIVE/PASSIVE

end

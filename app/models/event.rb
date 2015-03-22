class Event
  include Mongoid::Document

  belongs_to :player
  embeds_many :actions

  field :location_id, type: String
  field :event_template_id, type: String

  field :character_name, type: String
  field :detail, type: String
  field :dialogue, type: String

  field :chosen_action_key, type: String
  field :created_at, type: Time

end

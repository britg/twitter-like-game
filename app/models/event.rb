class Event
  include Mongoid::Document

  belongs_to :player

  field :location_id, type: String
  field :scripted_event_id, type: String
  field :event_template_id, type: String

  field :character_name, type: String
  field :detail, type: String
  field :dialogue, type: String

  field :actions, type: Hash
  field :chosen_action_key, type: String

  field :created_at, type: Time

end

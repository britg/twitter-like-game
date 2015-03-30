class Event
  include Mongoid::Document

  NEW_STATE       = "new"
  CURRENT_STATE   = "current"
  OLD_STATE       = "old"

  belongs_to :player
  embeds_many :actions

  field :sequence
  field :location_id, type: String
  field :event_template_id, type: String

  field :character_name, type: String
  field :detail, type: String
  field :dialogue, type: String

  field :chosen_action_key, type: String
  field :created_at, type: Time

  field :current_state, type: String, default: NEW_STATE

  def self.current
    where(current_state: CURRENT_STATE)
  end

end

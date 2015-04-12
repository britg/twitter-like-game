class Event
  include Mongoid::Document

  class InvalidAction < Exception; end

  NEW_STATE       = "new"
  CURRENT_STATE   = "current"
  OLD_STATE       = "old"

  belongs_to :player
  embeds_many :actions
  belongs_to :location

  field :sequence

  field :character_name, type: String
  field :detail, type: String
  field :dialogue, type: String

  field :chosen_action_key, type: String
  field :created_at, type: Time

  field :current_state, type: String, default: NEW_STATE

  def self.new_and_current
    where(current_state: [CURRENT_STATE, NEW_STATE])
  end

  def valid_action? action_slug
    actions.where(slug: action_slug).any?
  end

end

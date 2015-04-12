class Event
  include Mongoid::Document

  class InvalidAction < Exception; end

  TYPE_EXPLORATION = "exploration"
  TYPE_BATTLE      = "battle"

  NEW_STATE       = "new"
  CURRENT_STATE   = "current"
  OLD_STATE       = "old"

  belongs_to :player
  embeds_many :actions
  belongs_to :location

  field :type, type: String, default: TYPE_EXPLORATION
  after_create :add_default_actions

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
    actions.where(key: action_slug).any?
  end

  def exploration?
    self.type == TYPE_EXPLORATION
  end

  def add_default_actions
    add_exploration_actions if exploration?
  end

  def add_exploration_actions
    actions.create(label: "Explore", key: :explore)
  end

  def to_s
    [character_name, dialogue, detail].compact.join(' : ')
  end

end

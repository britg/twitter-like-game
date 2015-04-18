class Event
  include Mongoid::Document

  class InvalidAction < Exception; end

  TYPE_EXPLORATION = "exploration"
  TYPE_DETAIL      = "detail"
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

  def available_actions
    keys = []
    actions.each do |action|
      keys << action.key
      action.child_actions.each do |sub_action|
        keys << sub_action.key
      end
    end
    keys
  end

  def valid_action? action_slug
    available_actions.include?(action_slug.to_s)
  end

  def exploration?
    self.type == TYPE_EXPLORATION
  end

  def battle?
    self.type == TYPE_BATTLE
  end

  def add_default_actions
    add_exploration_actions if exploration?
    add_battle_actions if battle?
  end

  def add_exploration_actions
    actions.create(label: "Explore", key: :explore)
    actions.create(label: "Observe", key: :observe)
    find_action = actions.create(label: "Find", key: :find)
    find_action.child_actions.create(label: "Survival", key: :find_survival)
    find_action.child_actions.create(label: "Herbs", key: :find_herbs)
    actions.create(label: "Craft", key: :craft)
  end

  def add_battle_actions
    actions.create(label: "Attack", key: :attack)
    actions.create(label: "Special", key: :special)
    actions.create(label: "Flee", key: :flee)
  end

  def to_s
    [character_name, dialogue, detail].compact.join(' : ')
  end

end

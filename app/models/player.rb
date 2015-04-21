class Player
  include Mongoid::Document
  include HasAgent

  MODE_ACTIVE = "active"
  MODE_PASSIVE = "passive"

  CURRENT_ID = "current"

  field :continue_token, type: String
  index({ continue_token: 1 }, { unique: true })
  before_save :ensure_continue_token

  field :current_mode, type: String

  belongs_to :user
  belongs_to :battle
  belongs_to :location
  field :landmark_id

  belongs_to :inventory

  has_many :events
  has_many :location_states
  index({"location_states.location_id" => 1}, {unique: true})

  field :name, type: String
  field :experience, type: Integer
  field :level, type: Integer

  field :gold, type: Integer, default: configatron.player_gold

  def ensure_continue_token
    if continue_token.blank?
      self.continue_token = generate_continue_token
    end
  end

  def generate_continue_token
    loop do
      token = Devise.friendly_token
      break token unless Player.where(continue_token: token).first
    end
  end

  def to_s
    name
  end

  def player?
    true
  end

  ##
  # Possible States
  ##

  def exploring?
    !in_battle? && !interacting?
  end

  def interacting?
    landmark_id.present?
  end

  def in_battle?
    battle.present?
  end

  def travelling?
    # In a travel scene
    false
  end

  ##
  # Event Convenience Methods
  ##

  def current_event
    events.last
  end

  def recent_events
    events.order(_id: -1).limit(20).reverse
  end

  def new_events
    @new_events||=[]
  end

  def cache_new_event event
    new_events << event
  end

  def add_event params
    e = events.create(params.merge(created_at: Time.now))
    cache_new_event(e)
    e
  end

  ##
  # / End Event Convenience Methods
  ##

  ##
  # Location/Landmark Convenience Methods
  ##

  def travel_to location_slug
    enter_location(Location.slug(location_slug))
  end

  def enter_location location
    LocationProcessor.new(self, location).enter
  end

  def current_location_state
    location_states.where(location_id: location.id).first
  end

  def current_landmark_states
    current_location_state.landmark_states
  end

  # The currently interacting landmark
  def landmark
    location.landmarks.find(landmark_id)
  end

  ##
  # / End Location/Landmark Convenience Methods
  ##

  ##
  # Action Convenience Methods
  ##

  def action_processor
    @action_processor ||= ActionProcessor.new(self)
  end

  def available_actions
    action_processor.available_actions
  end

  def available_action_keys
    action_processor.available_action_keys
  end

  def input action_slug
    action_processor.process(action_slug)
  end

  def ex
    action_processor.explorer
  end

  ##
  # / End Action Convenience Methods
  ##

  def use_skill slug, metadata = {}
    SkillProcessor.new(self, slug, metadata).process
  end

  def reset! scene_anchor = nil
    events.delete_all
    update_attributes(location: nil,
                      battle: nil)
  end
end

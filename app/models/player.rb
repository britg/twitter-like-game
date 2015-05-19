class Player
  include Mongoid::Document
  include HasAgent

  attr_accessor :start_of_input_mark

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
  delegate :zone, to: :location
  field :landmark_id
  field :resource_node_id

  belongs_to :inventory

  has_many :events
  has_many :location_states
  has_many :quest_states
  has_many :bestiary_states

  field :name, type: String
  field :experience, type: Integer
  field :level, type: Integer, default: 1
  field :gold, type: Integer, default: configatron.player_gold

  has_many :equipment
  has_many :consumables
  has_many :quest_items
  has_many :vendor_items

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

  def story
    Story.new(player: self)
  end

  def gain_experience amount
    inc(experience: amount)
    add_event(detail: "+#{amount}XP (#{next_lvl_percent}% to level #{level+1})")
    if experience > next_lvl_xp
      inc(level: 1)
      add_event(detail: "Level up: #{level}")
    end
  end

  def current_lvl
    Level.slug(level)
  end

  def next_lvl
    Level.slug(level + 1)
  end

  def next_lvl_xp
    next_lvl.try(:xp) || Float::INFINITY
  end

  def next_lvl_progress
    experience - current_lvl.xp
  end

  def next_lvl_experience_amount
    next_lvl_xp - current_lvl.xp
  end

  def next_lvl_percent
    ((next_lvl_progress.to_f/next_lvl_experience_amount.to_f)*100.0).round
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

  def last_acted_event
    events.ne(chosen_action_key: nil).last
  end

  def recent_events
    events.order(created_at: -1).limit(20)
  end

  def mark_event_created_at
    if @start_of_input_mark.present?
      events.find(@start_of_input_mark).created_at
    else
      0
    end
  end

  def new_events
    events.order(created_at: -1).gt(created_at: mark_event_created_at).limit(20)
  end

  def add_event params
    if params.class == String
      params = {detail: params}
    end
    e = events.create(params.merge(
      created_at: Time.now,
      player_state_during_event: state_serialized
    ))
    e
  end

  def state_serialized
    reload
    serializer = PlayerSerializer.new(self)
    ActiveModel::Serializer.adapter.new(serializer).as_json
  end

  def consider!
    add_event("You consider your next course of action...")
  end

  ##
  # / End Event Convenience Methods
  ##

  ##
  # Location/Landmark Convenience Methods
  ##

  def can_travel?
    !in_battle?
  end

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

  def current_resource_node
    location.resource_nodes.find(resource_node_id)
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

  def mark_start_of_input event_id
    @start_of_input_mark = event_id
    # @start_of_input_mark = Time.now
  end

  def input action_slug
    action_processor.process(action_slug)
    reload
    check_dead
  end

  def check_dead
    if agent.dead?
      add_event(detail: "You're dead...")
      update_attributes(dead: true, continue_token: nil)
    end
  end

  def ex
    action_processor.explorer
  end

  def status_line
    return "Exploring #{location.to_s}" if exploring?
    return "Interacting with #{landmark.to_s}" if interacting?
    return "In battle!" if in_battle?
  end

  ##
  # / End Action Convenience Methods
  ##

  def use_skill slug, metadata = {}
    SkillProcessor.new(self, slug, metadata).process
  end

  def use_main_hand_skill
    # TODO refactor to use the actual skill associated with the
    # weapon in your main hand
    sk = main_hand.equipment.skill
    use_skill(sk.slug)
  end

  def reset! scene_anchor = nil
    events.delete_all
    update_attributes(location: nil,
                      battle: nil)
  end
end

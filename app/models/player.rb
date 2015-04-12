class Player
  include Mongoid::Document

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

  has_many :events
  has_many :player_locations
  index({"player_locations.location_id" => 1}, {unique: true})

  embeds_one :agent
  embeds_many :skills

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

  def in_battle?
    battle.present?
  end

  def travelling?
    # In a travel scene
    false
  end

  def current_event
    events.last
  end

  def available_actions
    current_event.actions.map(&:key)
  end

  def recent_events
    events.order(sequence: -1).limit(20).reverse
  end

  def enter_location location
    LocationProcessor.new(self, location).enter
  end

  def current_player_location
    player_locations.where(location_id: location.id).first
  end

  def action_processor
    @action_processor ||= ActionProcessor.new(self)
  end

  def take_action action_slug
    action_processor.process(action_slug)
  end

  def reset! scene_anchor = nil
    events.delete_all
    update_attributes(location: nil,
                      battle: nil)
  end

end

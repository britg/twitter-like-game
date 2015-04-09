class Player
  include Mongoid::Document

  CURRENT_ID = "current"

  MODE_ACTIVE = "active"
  MODE_PASSIVE = "passive"

  belongs_to :user
  has_many :events
  belongs_to :battle

  embeds_one :agent

  field :continue_token, type: String
  index({ continue_token: 1 }, { unique: true })

  field :current_mode, type: String

  field :name, type: String
  field :experience, type: Integer
  field :level, type: Integer

  field :gold, type: Integer, default: configatron.player.gold

  field :previous_scene, type: String, default: configatron.default_scene
  field :previous_event_sequence, type: Integer, default: 0
  field :current_scene, type: String, default: configatron.default_scene
  field :current_event_sequence, type: Integer, default: 0
  field :current_location_slug, type: String

  before_save :ensure_continue_token

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

  def scene
    @scene ||= SceneRunner.new(self)
  end

  def current_event
    events.last
  end

  def marker
    scene.marker
  end

  def recent_events
    events.order(sequence: -1).limit(20).reverse
  end

  def location
    Location.where(slug: current_location_slug.to_sym).first
  end

  def in_battle?
    battle.present?
  end

  def reset!
    events.delete_all
    update_attributes(current_event_sequence: nil,
                      current_scene: "intro",
                      battle: nil)
  end

  def input action = nil
    if in_battle?
      battle.proceed self, action
    else
      scene.proceed action
    end
    events.last
  end

end

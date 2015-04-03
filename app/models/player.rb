class Player
  include Mongoid::Document

  CURRENT_ID = "current"

  MODE_ACTIVE = "active"
  MODE_PASSIVE = "passive"

  belongs_to :user
  has_many :events

  # Location management
  belongs_to :location

  field :continue_token, type: String
  index({ continue_token: 1 }, { unique: true })

  field :current_mode, type: String

  field :name, type: String
  field :experience, type: Integer
  field :level, type: Integer

  field :hp, type: Integer, default: configatron.player.hp
  field :ap, type: Integer, default: configatron.player.ap

  field :gold, type: Integer, default: configatron.player.gold

  field :strength, type: Integer, default: configatron.player.strength
  field :dexterity, type: Integer, default: configatron.player.dexterity
  field :stamina, type: Integer, default: configatron.player.stamina
  field :intelligence, type: Integer, default: configatron.player.intelligence
  field :luck, type: Integer, default: configatron.player.luck

  field :previous_context, type: String, default: configatron.default_context
  field :current_context, type: String, default: configatron.default_context
  field :current_event_sequence, type: Integer, default: 0

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

  def story
    @action_handler ||= StoryEngine.new(self)
  end

  def current_event
    events.last
  end

  def marker
    story.marker
  end

  def recent_events
    events.order(sequence: -1).limit(20).reverse
  end

end

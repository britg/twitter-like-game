class Player
  include Mongoid::Document

  CURRENT_ID = "current"

  MODE_ACTIVE = "active"
  MODE_PASSIVE = "passive"

  DEFAULT_CHAPTER = "intro"

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

  field :hp, type: Integer
  field :ap, type: Integer

  field :gold, type: Integer

  field :strength, type: Integer
  field :dexterity, type: Integer
  field :stamina, type: Integer
  field :intelligence, type: Integer
  field :luck, type: Integer

  field :previous_chapter, type: String, default: DEFAULT_CHAPTER
  field :current_chapter, type: String, default: DEFAULT_CHAPTER
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

  def action_handler
    @action_handler ||= ActionHandler.new(self)
  end
  alias_method :story, :action_handler

  def current_event
    events.last
  end

  def hero
    action_handler.hero
  end

  def recent_events
    events.order(sequence: -1).limit(20).reverse
  end

end

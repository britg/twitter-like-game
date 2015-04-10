class Player
  include Mongoid::Document

  CURRENT_ID = "current"

  belongs_to :user
  has_many :events
  belongs_to :battle

  embeds_one :agent
  embeds_one :scene_anchor

  field :continue_token, type: String
  index({ continue_token: 1 }, { unique: true })

  field :current_mode, type: String

  field :name, type: String
  field :experience, type: Integer
  field :level, type: Integer

  field :gold, type: Integer, default: configatron.player.gold

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

  def tick
    if in_battle?
      battle.proceed
    end
    events.last
  end

end

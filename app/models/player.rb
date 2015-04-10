class Player
  include Mongoid::Document

  MODE_ACTIVE = "active"
  MODE_PASSIVE = "passive"

  CURRENT_ID = "current"

  belongs_to :user
  has_many :events
  belongs_to :battle
  belongs_to :location

  embeds_one :agent
  embeds_one :scene_anchor
  embeds_one :exploration_state

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

  def in_battle?
    battle.present?
  end

  def travelling?
    # In a travel scene
    false
  end

  def enter_location location
    LocationProcessor.new(self, location).enter
  end

  def explorer
    @explorer ||= ExplorationProcessor.new(self)
  end

  def explore
    explorer.tick
    current_event
  end

  def tick
    if in_battle?
      battle.proceed
    elsif travelling?
    else # at a location
      explore
    end
    events.last
  end

  def reset! scene_anchor = nil
    events.delete_all
    scene_anchor ||= SceneAnchor.new(scene_slug: :intro, sequence: -1)
    update_attributes(current_event_sequence: nil,
                      scene_anchor: scene_anchor,
                      battle: nil)
  end

end

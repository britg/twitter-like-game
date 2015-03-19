class Player
  include Mongoid::Document

  CURRENT_ID = "current"

  has_many :player_locations
  has_one :current_location, class_name: "PlayerLocation"

  field :continue_token, type: String
  index({ continue_token: 1 }, { unique: true })

  field :name, type: String
  field :experience, type: Integer
  field :hitpoints, type: Integer
  field :attack, type: Integer
  field :defense, type: Integer
  field :gold, type: Integer

  def current_location_url
    current_location.try(:url) || "/"
  end

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

end

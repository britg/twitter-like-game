class Event
  include Mongoid::Document

  class InvalidAction < Exception; end

  belongs_to :player
  index({player_id: 1})

  field :character_name, type: String
  field :detail, type: String
  field :dialogue, type: String
  field :chosen_action_key, type: String

  field :created_at, type: Time

  def to_s
    [character_name, dialogue, detail].compact.join(' : ')
  end

end

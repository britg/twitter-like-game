class Event
  include Mongoid::Document

  class InvalidAction < Exception; end

  belongs_to :player
  belongs_to :location

  field :character_name, type: String
  field :detail, type: String
  field :dialogue, type: String

  field :created_at, type: Time

  def to_s
    [character_name, dialogue, detail].compact.join(' : ')
  end

end

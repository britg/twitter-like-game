class EventTemplate
  include Mongoid::Document

  belongs_to :character
  embeds_many :actions

  field :sequence, type: Integer
  field :detail, type: String
  field :dialogue, type: String

end

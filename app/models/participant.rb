class Participant
  include Mongoid::Document

  belongs_to :player

  belongs_to :npc
  embeds_one :agent

  embedded_in :battle

end
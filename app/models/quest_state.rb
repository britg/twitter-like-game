class QuestState
  include Mongoid::Document

  belongs_to :player, index: true
  belongs_to :quest

end
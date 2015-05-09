class QuestReward
  include Mongoid::Document

  embedded_in :quest

  belongs_to :equipment_blueprint
  field :quantity, type: Integer, default: 1

end

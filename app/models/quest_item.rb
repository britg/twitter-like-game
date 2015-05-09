class QuestItem
  include Mongoid::Document

  belongs_to :player, index: true
  belongs_to :quest_item_blueprint

  field :name, type: String

end

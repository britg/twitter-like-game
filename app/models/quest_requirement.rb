class QuestRequirement
  include Mongoid::Document

  embedded_in :quest

  belongs_to :quest_item_blueprint
  field :quantity, type: Integer, default: 1

  def _quest_item= slug
    self.quest_item_blueprint = QuestItemBlueprint.slug(slug)
  end

end

class QuestItemCreator

  def initialize blueprint, player
    @blueprint = blueprint
    @player = player
  end

  def create
    @item = QuestItem.new(
      player: @player,
      quest_item_blueprint: @blueprint,
      name: @blueprint.name
    )

    @item.save and @item
  end

end

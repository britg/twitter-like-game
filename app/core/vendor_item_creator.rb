class VendorItemCreator

  def initialize player, blueprint
    @blueprint = blueprint
    @player = player
  end

  def create
    @item = VendorItem.new(
      name: @blueprint.name,
      gold_value: @blueprint.gold_value,
      player: @player
    )

    @item.save and @item
  end
end

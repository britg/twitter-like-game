class Item
  include Mongoid::Document

  field :equippable
  belongs_to :slot

  def equippable?
    true
  end

end

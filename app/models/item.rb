class Item
  include Mongoid::Document

  field :equippable

  def equippable?
    true
  end

end
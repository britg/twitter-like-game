class Item < ActiveHash::Base

  field :equippable

  def equippable?
    true
  end

end
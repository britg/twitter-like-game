class Consumable
  include Mongoid::Document

  belongs_to :player, index: true

end

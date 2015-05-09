class VendorItem
  include Mongoid::Document

  belongs_to :player, index: true

  field :name, type: String
  field :gold_value, type: Integer

end

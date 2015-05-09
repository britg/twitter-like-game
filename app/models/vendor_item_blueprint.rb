class VendorItemBlueprint
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  field :gold_value_range, type: Range

  def gold_value
    rand(gold_value_range)
  end

end

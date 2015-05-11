class Stat
  include Mongoid::Document
  include HasSlug
  include HasCalculator

  field :name, type: String
  field :base_value, type: Float

end

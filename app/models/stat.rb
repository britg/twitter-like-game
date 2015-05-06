class Stat
  include Mongoid::Document
  include HasSlug
  include HasCalculator

  field :name, type: String

end

class Level
  include Mongoid::Document
  include HasSlug

  field :xp, type: Integer

end
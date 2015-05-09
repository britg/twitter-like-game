class QuestItemBlueprint
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  field :description, type: String

end

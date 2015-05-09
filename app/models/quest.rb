class Quest
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  field :description, type: String
  field :level_range, type: Range

  field :gold_reward, type: Integer
  field :experience_reward, type: Integer

  embeds_many :quest_rewards
  embeds_many :quest_requirements

end

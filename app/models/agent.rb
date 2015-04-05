class Agent < ActiveHash::Base

  field :name
  field :slug
  field :aliases
  field :hp
  field :ap
  field :gold
  field :strength
  field :dexterity
  field :stamina
  field :intelligence
  field :luck

end

unless Rails.application.config.eager_load
  Dir["#{Rails.root}/app/game/agents/*.rb"].each {|file| require file }
end

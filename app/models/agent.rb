class Agent < ActiveHash::Base

  field :name
  field :slug
  field :aliases
  field :gold
  field :attack_power
  field :strength
  field :dexterity
  field :stamina
  field :intelligence
  field :luck

  def hp
    stamina * configatron.stamina_to_hp_multiplier + hp_bonuses
  end

  def hp_bonuses
    0 # compute this value
  end

  def ap

  end

end

unless Rails.application.config.eager_load
  Dir["#{Rails.root}/app/game/agents/*.rb"].each {|file| require file }
end

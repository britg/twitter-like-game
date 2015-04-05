class Ability < ActiveHash::Base

  field :name
  field :slug

end

unless Rails.application.config.eager_load
  Dir["#{Rails.root}/app/game/abilities/*.rb"].each {|file| require file }
end

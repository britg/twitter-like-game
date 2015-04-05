class Location < ActiveHash::Base

  field :name
  field :slug
  field :path

end

unless Rails.application.config.eager_load
  Dir["#{Rails.root}/app/game/locations/*.rb"].each {|file| require file }
end

Rails.application.routes.draw do

  devise_for :users
  root to: "application#ember_start"

  namespace :api do
    namespace :v1 do
      resources :players
    end
  end

  match '*path', via: :all, to: "application#ember_start"

end

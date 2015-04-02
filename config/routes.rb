Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'api/v1/sessions' }
  root to: "home#index"

  namespace :api do
    namespace :v1 do
      resources :users
      resources :players
      resources :locations
    end
  end

end

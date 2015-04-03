Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'api/v1/sessions' }
  root to: "home#index"
  resources :players, only: :create

  namespace :api do
    namespace :v1 do
      resources :users
      resources :players
      resources :locations
    end
  end

  match '*path', via: :all, to: "game#index"

end

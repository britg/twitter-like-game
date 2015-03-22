Rails.application.routes.draw do

  namespace :api do
  namespace :v1 do
    get 'actions/create'
    end
  end

  devise_for :users, controllers: { sessions: 'api/v1/sessions' }
  root to: "application#ember_start"

  namespace :api do
    namespace :v1 do
      resources :users
      resources :players
      resources :locations
      resources :actions, only: [:create]
    end
  end

  match '*path', via: :all, to: "application#ember_start"

end

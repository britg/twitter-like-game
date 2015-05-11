Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'api/v1/sessions' }
  root to: "home#index"
  resources :players, only: :create
  get "/game", to: "game#index", as: :game

  namespace :api do
    namespace :v1 do
      resources :players, only: :show
      resources :actions, only: :create
      resources :map, only: [:index, :update]
      resources :story, only: [:index]
      get 'chat' => 'chat#chat'
    end
  end

  match '*path', via: :all, to: "game#index"

end

Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'api/v1/sessions' }
  root to: "home#index"
  resources :players, only: :create
  get "/game", to: "game#index", as: :game
  get "/landmarks", to: "game#landmarks", as: :landmarks
  get "/inventory", to: "game#inventory", as: :inventory
  get "/stats", to: "game#stats", as: :stats
  get "/chat", to: "chat#index", as: :chat

  namespace :api do
    namespace :v1 do
      resources :players, only: :show
      resources :actions, only: :create
      get 'chat' => 'chat#chat'
    end
  end

  match '*path', via: :all, to: "game#index"

end

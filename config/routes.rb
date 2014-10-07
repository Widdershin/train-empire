Rails.application.routes.draw do
  devise_for :users

  root to: 'games#index'

  get '/games/:id/action_count', to: 'games#action_count'

  resources :games do
    resources :players

    member do
      get '/game_over', to: 'games#game_over'
      post '/actions/create', to: 'actions#create'
    end
  end
end

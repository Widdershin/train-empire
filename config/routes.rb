Rails.application.routes.draw do
  devise_for :users

  root to: 'games#index'

  resources :games do
    resources :players

    member do
      post '/actions/:action', controller: 'actions'
    end
  end
end

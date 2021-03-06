Rails.application.routes.draw do
  root to: "links#index"
  
  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
  get '/home', to: 'users#unauthenticated'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :links, only: [:index, :create]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end

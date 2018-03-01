Rails.application.routes.draw do

  root to:"welcome#index"
  resources :users

  get '/login' =>'sessions#new', as: 'login'
  post '/login' => 'sessions#create', as: 'sessions'
  get '/logout' => 'sessions#destroy', as:'logout'

  get '/signup' =>'users#new', as:'signup'

  resources :sessions
end

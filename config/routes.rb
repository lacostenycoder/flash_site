Rails.application.routes.draw do
  root "welcome#index"
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  resources :customers do
    get :confirm_email, on: :member
    get :reset_password, on: :member
    get :forgot_password, on: :collection
    post :send_reset_password_email, on: :collection
    patch :update_password, on: :member
  end

  namespace :admin do
    root 'users#index'
    resources :users
  end

  post '/customers', to: 'users#create'
end

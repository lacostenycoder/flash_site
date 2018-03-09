Rails.application.routes.draw do
  root "welcome#index"
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  resources :users do
    get :confirm_email, on: :member
    get :reset_password, on: :member
    get :forgot_password, on: :collection
    post :send_reset_password_email, on: :collection
  end
end

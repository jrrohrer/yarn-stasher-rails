Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#welcome'

  get '/signup', to: 'users#new' # don't need a post signup, since our users resource already has one
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/home', to: 'users#index'
  get '/ordered_comments', to: 'comments#ordered_comments'

  # google oauth callback route
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

  resources :comments
  resources :projects do 
    resources :comments, only: [:index, :new, :create, :show]
  end
  resources :yarns, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :users, only: [:new, :create, :show]

  # this route matches any url that is invalid and will send to the not_found method in the application controller, which renders a 404 page.
  match '*path', to: 'application#not_found', via: [:get, :post]
end

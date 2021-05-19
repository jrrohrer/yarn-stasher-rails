Rails.application.routes.draw do
  root 'sessions#home'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/signup', to: 'users#new'
  # don't need a post signup, since our users resource already has one

  resources :comments
  resources :projects
  resources :yarns
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

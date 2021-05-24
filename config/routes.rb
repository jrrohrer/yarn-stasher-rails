Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sessions#home'

  get '/signup', to: 'users#new' # don't need a post signup, since our users resource already has one
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  

  resources :comments
  resources :projects do 
    resources :comments, shallow: true
    # gives me shallow routing for the nested comments resource: index, new, and edit only. 
  end
  resources :yarns
  resources :users

end

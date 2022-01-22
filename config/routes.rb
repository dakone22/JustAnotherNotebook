Rails.application.routes.draw do
  resources :sessions, only: %i[new create destroy]
  resources :users
  resources :notes
  get '/signin', to: 'sessions#new'
  get '/signup', to: 'users#new'
  root 'notes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

  root to: 'welcome#home'
  resources :trips, only: [:index, :show]

  get 'welcome/home',  to: 'welcome#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :orders, only: [:show]

  resources :users, only: [:new, :create]
  get '/dashboard', to: 'users#dashboard'
  get '/bike_shop', to: 'bike_shop#index'

  resources :stations, only: [:index], param: :slug

  resources :conditions, only: [:index, :show]


  resources :accessories, only: [:show], param: :slug

  resources :checkout, only: [:create]

  post '/cart', to: 'carts#create'
  get '/cart', to: 'carts#show'

  get '/:slug', to: 'stations#show', as: "station"

  namespace :admin do
    resources :stations, only: [:index]
  end
end

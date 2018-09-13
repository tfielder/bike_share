Rails.application.routes.draw do

  root to: 'welcome#home'
  resources :trips, only: [:index, :show]

  get 'welcome/home',  to: 'welcome#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/condition-dashboard', to: 'conditions#dashboard'

  resources :orders, only: [:show]
  # resources :order_accessories, only: [:create, :update, :destroy]
  resources :users, only: [:new, :create, :edit, :update]
  get '/dashboard', to: 'users#dashboard'
  post '/dashboard', to: 'users#dashboard'
  get '/bike_shop', to: 'bike_shop#index'
  get '/stations-dashboard', to: 'stations#dash'

  get '/condition-dashboard', to: 'conditions#dashboard'

  resources :stations, only: [:index], param: :slug

  resources :conditions, only: [:index, :show]


  resources :accessories, only: [:show], param: :slug

  resources :checkout, only: [:create]

  post '/cart', to: 'carts#create'
  get '/cart', to: 'carts#show'
  delete '/cart', to: 'carts#destroy'
  put '/cart', to:'carts#increase'
  patch '/cart', to:'carts#decrease'


  get '/:slug', to: 'stations#show', as: "station"

  namespace :admin do
    resources :stations, only: [:index, :show, :edit, :update, :destroy, :new, :create], param: :slug
  end

  namespace :admin do
    resources :trips, only: [:index, :show]
  end


end

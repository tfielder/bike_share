Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#home'
  get 'welcome/home',  to: 'welcome#home'
  get '/bike_shop', to: 'bike_shop#index'

  resources :stations, only: [:index, :show], param: :slug

  resources :conditions, only: [:index, :show]
end

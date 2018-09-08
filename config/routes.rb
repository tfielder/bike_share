Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#home'
  get 'welcome/home',  to: 'welcome#home'
  get '/login', to: 'sessions#new'

  resources :user, only: [:new, :create]

  resources :stations, only: [:index, :show], param: :slug

  resources :conditions, only: [:index, :show]


end

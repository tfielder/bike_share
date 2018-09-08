Rails.application.routes.draw do
  root to: 'welcome#home'
  resources :trips, only: [:index]
  get 'welcome/home',  to: 'welcome#home'
end

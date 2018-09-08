Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :conditions, only: [:index, :show]

  root to: 'welcome#home'
  get 'welcome/home',  to: 'welcome#home'
end

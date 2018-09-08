Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD
  resources :conditions, only: [:index, :show]

=======
  root to: 'welcome#home' 
  get 'welcome/home',  to: 'welcome#home'
>>>>>>> d1e039ed5c9edeaf441530986ce6302a440ed452
end

Rails.application.routes.draw do

  resources :questions
  resources :advertisements
  resources :topics do

  resources :posts, except: [:index]
end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  post 'users/confirm' => 'users#confirm'
  get 'welcome/contact'
  get 'welcome/faq'

  get 'about' => 'welcome#about'



  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

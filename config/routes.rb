Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'gossips#index'
  resources :user, only: [:show, :new, :create]
  resources :team, only: [:index] #infos de la team
  resources :contacts, only: [:index] #infos contacts
  resources :gossips  do
    resources :comments
  end

  resources :sessions, only: [:new, :create, :destroy]
  #Utilisateurs admins
  #namespace :admin do
  #  resources :users, :gossips
  #end
end

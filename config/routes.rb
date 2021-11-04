Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :microposts, only: [:create, :destroy]
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :favoriteings
      get :favoriteers
    end
  end

  resources :microposts, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end

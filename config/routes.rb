Rails.application.routes.draw do
  resources :styles
  resources :memberships do
    post 'confirm', on: :member
  end
  resources :beer_clubs
  resources :users do
    post 'toggle_blocked', on: :member
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only:[:index, :show]

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  root 'breweries#index'
  get 'places', to: 'places#index'
  post 'places', to:'places#search'

  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'
end

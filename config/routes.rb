Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'
  get 'aline' => 'alines#aline'
  resources :users,only: [:show,:index,:edit,:update] do
    member do
    get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end


end
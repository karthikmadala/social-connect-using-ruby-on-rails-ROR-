Rails.application.routes.draw do
  get "users/index"
  get "home/index"
  get "admin/dashboard"
  devise_for :users

  authenticated :user do
    root "home#index", as: :authenticated_root
  end


  resources :friendships, only: [ :index, :create, :destroy ] do
    collection do
      get :requests # Route for viewing received friend requests
      delete :unfriend
    end
    member do
      post :accept
      delete :reject
      delete :unfriend
    end
  end
  resources :users, only: [:destroy] do
    get "profile", on: :member, to: "users#profile", as: "profile"
  end

  delete "friendships/unfriend/:friend_id", to: "friendships#unfriend", as: "unfriend"


  get "friend_requests", to: "friendships#requests"

  resources :users, only: [ :index ,:destroy]

  get "friends", to: "users#friends"

  root "welcome#index"

  namespace :admin do
    get "dashboard", to: "admin#dashboard"
  end
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
end

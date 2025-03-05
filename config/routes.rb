Rails.application.routes.draw do
  get "comments/index"
  get "posts/index"
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
  resources :users, only: [ :destroy ] do
    get "profile", on: :member, to: "users#profile", as: "profile"
  end

  delete "friendships/unfriend/:friend_id", to: "friendships#unfriend", as: "unfriend"


  get "friend_requests", to: "friendships#requests"

  resources :users, only: [ :index, :destroy ]

  get "friends", to: "users#friends"
  root "welcome#index"

  namespace :admin do
    get "dashboard", to: "admin#dashboard"
  end
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  resources :notifications, only: [ :index ] do
    collection do
      get "recent"
    end
    member do
      patch "mark_as_read"
    end
  end

  resources :posts do
    resources :comments, only: [ :create, :destroy ]
    resources :likes, only: [ :create, :destroy ]  # ✅ Add this line for likes
  end
end

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: "users/sessions"
  }, path: "auth", path_names: {
    sign_in: "login",
    sign_out: "logout",
    password: "secret",
    confirmation: "verification",
    unlock: "unblock",
    registration: "register",
    sign_up: "cmon_let_me_in"
  }

  namespace :api do
    resources :users
    resources :books
  end

  resources :books do
    member do
      post :borrow
      resources :comments, only: [ :destroy ]
    end
  end

  resources :borrowed_books, only: [ :index, :show, :update ] do
    member do
      post :return
      post :comment
    end
  end

  root to: "home#index"
end

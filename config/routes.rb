Rails.application.routes.draw do
  # ActiveAdmin routes
  ActiveAdmin.routes(self)

  # Devise routes with custom controllers and path names
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, path: "auth", path_names: {
    sign_in: "login",
    sign_out: "logout",
    password: "secret",
    confirmation: "verification",
    unlock: "unblock",
    registration: "register",
    sign_up: "cmon_let_me_in"
  }

  # Root route
  root to: "home#index"
end

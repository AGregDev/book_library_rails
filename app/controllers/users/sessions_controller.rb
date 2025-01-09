class Users::SessionsController < Devise::SessionsController
  def create
    super
    current_user.logs.create(action: "login", details: "User logged in at #{Time.current}")
  end

  def destroy
    current_user.logs.create(action: "logout", details: "User logged out at #{Time.current}") if user_signed_in?
    super
  end
end

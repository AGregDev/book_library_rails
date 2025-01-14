module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [ :show, :update, :destroy ]

    def index
      @users = User.all
      render json: @users
    end

    def show
      render json: @user
    end

    def create
      @user = User.new(user_params)
      authorize @user

      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      authorize @user

      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @user

      @user.destroy
      head :no_content
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if current_user.is_admin?
        params.require(:user).permit(:email, :password, :role)
      else
        params.require(:user).permit(:email, :password)
      end
    end
  end
end

# frozen_string_literal: true

class UsersController < ApplicationController
  layout "auth"

  def new
    @user = User.new
  end

  def create
    user = User.new(permitted_params)

    if user.save
      session[:user_id] = user.id

      redirect_to root_path
    else
      @user = user || User.new

      render :new, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

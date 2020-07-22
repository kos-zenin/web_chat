# frozen_string_literal: true

class SessionsController < ApplicationController
  layout "auth"
  before_action :authorize_user!, only: %(destroy)

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: permitted_params[:email])

    if user&.authenticate(permitted_params[:password])
      session[:user_id] = user.id

      redirect_to root_path
    else
      @error = "Unable to log in, check your credentials please"
      @user = user || User.new

      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to new_sessions_path
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :password)
  end
end

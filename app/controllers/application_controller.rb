# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  private

  def current_user
    User.find(session.fetch(:user_id)) if session.has_key?(:user_id)
  end

  def logged_in?
    !!current_user
  end

  def authorize_user!
    redirect_to new_sessions_path unless logged_in?
  end
end

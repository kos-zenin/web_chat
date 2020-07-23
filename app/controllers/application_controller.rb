# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  private

  def current_user
    @_current_user ||= User.find(session.fetch(:user_id)) if session.key?(:user_id)
  end

  def current_chat
    @current_chat ||= CurrentChat.new.load
  end

  def logged_in?
    current_user.present?
  end

  def authorize_user!
    redirect_to new_sessions_path unless logged_in?
  end
end

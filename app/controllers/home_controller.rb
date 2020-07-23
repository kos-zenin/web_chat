# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authorize_user!

  def index
    @chat = current_chat
    @messages = @chat.messages.preload(:user).order(created_at: :asc)
  end
end

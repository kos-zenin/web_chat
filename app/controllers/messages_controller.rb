# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authorize_user!

  def create
    chat = Chat.instance

    chat.messages.create(user: current_user, content: permitted_params[:content])

    redirect_to root_path
  end

  private

  def permitted_params
    params.require(:message).permit(:content)
  end
end

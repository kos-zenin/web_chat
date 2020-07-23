# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authorize_user!

  def create
    message = current_chat.messages.new(user: current_user, content: permitted_params[:content])

    broadcast_notifications(message) if message.save
  end

  private

  def permitted_params
    params.require(:message).permit(:content)
  end

  def broadcast_notifications(message)
    ::NewMessageJob.perform_later(message.id)
  end
end

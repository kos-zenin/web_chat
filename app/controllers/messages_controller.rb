# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authorize_user!

  def create
    chat = Chat.instance

    message = chat.messages.new(user: current_user, content: permitted_params[:content])

    broadcast_notifications(message) if message.save
  end

  private

  def permitted_params
    params.require(:message).permit(:content)
  end

  def broadcast_notifications(message)
    ::ChatChannel.broadcast_to("chat", serialize_message(message))
  end

  def serialize_message(message)
    {
      created_at: message.created_at.to_s(:short),
      user_email: message.user.email,
      content: message.content
    }
  end
end

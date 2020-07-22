# frozen_string_literal: true

class NewMessageJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    ::ChatChannel.broadcast_to("chat", serialize_message(message))
  end

  private

  def serialize_message(message)
    {
      created_at: message.created_at.to_s(:short),
      user_email: message.user.email,
      content: message.content
    }
  end
end

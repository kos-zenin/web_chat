# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for "chat"
  end
end

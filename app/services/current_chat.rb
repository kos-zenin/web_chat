# frozen_string_literal: true

class CurrentChat
  def load
    Chat.first || Chat.create
  end
end

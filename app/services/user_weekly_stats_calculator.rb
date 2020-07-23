# frozen_string_literal: true

class UserWeeklyStatsCalculator
  def initialize(user)
    @user = user
  end

  def call
    {
      number_of_messages_during_last_week: number_of_messages_during_last_week,
      number_of_messages_since_your_last_message: number_of_messages_since_your_last_message,
      last_message_sent_at: last_message_created_at
    }
  end

  private

  def chat
    @chat ||= CurrentChat.new.load
  end

  def number_of_messages_during_last_week
    chat.messages.in_period(from: 1.week.ago, to: Time.current).count
  end

  def number_of_messages_since_your_last_message
    return if last_message_created_at.blank?

    chat.messages.in_period(from: last_message_created_at, to: Time.current).count
  end

  def last_message_created_at
    @last_message_created_at ||= begin
      @chat.messages
           .select("user_id, created_at")
           .where(user_id: @user.id)
           .order(id: :desc)
           .limit(1)
           .last
        &.created_at
    end
  end
end

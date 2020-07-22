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
    @chat ||= Chat.instance
  end

  def number_of_messages_during_last_week
    chat.messages
        .where(
          "created_at >= :start_date AND created_at <= :end_date", {
            start_date: 1.week.ago,
            end_date: Time.current
          }
        )
        .count
  end

  def number_of_messages_since_your_last_message
    return if last_message_created_at.blank?

    chat.messages
        .where(
          "created_at >= :start_date AND created_at <= :end_date", {
            start_date: last_message_created_at,
            end_date: Time.current
          }
        )
        .count
  end

  def last_message_created_at
    @last_message_created_at ||= @chat.messages.where(user_id: @user.id).order(id: :desc).limit(1).last&.created_at
  end
end

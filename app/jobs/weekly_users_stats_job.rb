# frozen_string_literal: true

class WeeklyUsersStatsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = ::User.find(user_id)

    ::UserMailer.weekly_stats(user.id, calculate_stats(user)).deliver_later
  end

  private

  def calculate_stats(user)
    ::UserWeeklyStatsCalculator.new(user).call
  end
end

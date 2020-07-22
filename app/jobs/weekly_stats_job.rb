# frozen_string_literal: true

class WeeklyStatsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    ::User.find_each do |user|
      ::WeeklyUsersStatsJob.perform_later(user.id)
    end
  end
end

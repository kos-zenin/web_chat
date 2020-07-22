# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def weekly_stats(user_id, stats)
    @user = User.find(user_id)
    @stats = stats

    mail(to: @user.email, subject: "Your weekly stats")
  end
end

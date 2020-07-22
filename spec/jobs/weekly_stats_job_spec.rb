# frozen_string_literal: true

require "rails_helper"

describe WeeklyStatsJob, type: :job do
  let(:user) { build_stubbed(:user) }

  it "enqueues bg job for each user stats" do
    expect(::User).to receive(:find_each).and_yield(user)
    expect(::WeeklyUsersStatsJob).to receive(:perform_later).with(user.id)

    described_class.perform_now
  end
end

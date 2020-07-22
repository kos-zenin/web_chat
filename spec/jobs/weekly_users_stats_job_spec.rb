# frozen_string_literal: true

require "rails_helper"

describe WeeklyUsersStatsJob, type: :job do
  let(:user) { build_stubbed(:user) }
  let(:calculator) { instance_double(::UserWeeklyStatsCalculator, call: { count: 10 }) }
  let(:message) { instance_double("message") }

  before do
    expect(::User).to receive(:find).with(user.id).and_return(user)
    expect(::UserWeeklyStatsCalculator).to receive(:new).with(user).and_return(calculator)
    expect(::UserMailer).to receive(:weekly_stats).with(user.id, { count: 10 }).and_return(message)
  end

  describe "#perform" do
    it "calculates statistics for the user and sends an email in bg" do
      expect(message).to receive(:deliver_later)

      described_class.perform_now(user.id)
    end
  end
end

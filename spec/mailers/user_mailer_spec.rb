# frozen_string_literal: true

require "rails_helper"

describe UserMailer do
  let(:last_email) { ActionMailer::Base.deliveries.last }
  let(:user) { build_stubbed(:user) }
  let(:stats) { {} }

  describe "#weekly_stats" do
    before do
      expect(::User).to receive(:find).with(user.id).and_return(user)
    end

    it "sends email notification to the given user" do
      described_class.weekly_stats(user.id, stats).deliver_now
      expect(last_email.to).to eq [user.email]
      expect(last_email.subject).to eq("Your weekly stats")
    end
  end
end

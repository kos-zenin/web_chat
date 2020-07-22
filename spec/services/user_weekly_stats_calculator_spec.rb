# frozen_string_literal: true

require "rails_helper"

describe ::UserWeeklyStatsCalculator do
  subject { described_class.new(user) }

  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:chat) { create(:chat) }
  let(:last_message) { create(:message, chat: chat, user: user, created_at: last_message_created_at) }
  let(:last_message_created_at) { Time.current - 21.days }

  let(:number_of_messages_during_last_week) { 7 }
  let(:number_of_messages_since_your_last_message) { 21 }

  let(:expected_statistics) do
    {
      number_of_messages_during_last_week: number_of_messages_during_last_week,
      number_of_messages_since_your_last_message: number_of_messages_since_your_last_message,
      last_message_sent_at: last_message_created_at
    }
  end

  let(:generate_messages) do
    last_message

    20.times do |index|
      create(:message, chat: chat, user: user2, created_at: Time.current - index.days)
    end
  end

  before do
    generate_messages
  end

  describe "#call" do
    it "calculates correct statistics" do
      expect(subject.call).to eq(expected_statistics)
    end
  end
end

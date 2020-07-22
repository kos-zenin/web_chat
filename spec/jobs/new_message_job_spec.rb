# frozen_string_literal: true

require "rails_helper"

describe NewMessageJob, type: :job do
  describe "perform" do
    let(:message) { build_stubbed(:message, content: "content") }
    let(:created_at) { Time.current }
    let(:serialized_message) do
      {
        created_at: created_at.to_s(:short),
        user_email: message.user.email,
        content: message.content
      }
    end

    it "broadcasting to chat channel" do
      expect(Message).to receive(:find).with(message.id).and_return(message)
      expect(::ChatChannel).to receive(:broadcast_to).with("chat", serialized_message)

      described_class.perform_now(message.id)
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

describe ::ApplicationCable::Connection, type: :channel do
  describe "#connect" do
    let(:stubbed_session) { { user_id: user.id } }
    let(:user) { build_stubbed(:user) }

    it "successfully connects" do
      expect(User).to receive(:find_by).with(id: user.id).and_return(user)

      connect "/cable", session: { user_id: user.id }
      expect(connection.current_user.id).to eq(user.id)
    end

    it "rejects connection" do
      expect { connect "/cable" }.to have_rejected_connection
    end
  end
end

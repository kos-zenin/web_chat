# frozen_string_literal: true

require "rails_helper"

describe MessagesController, type: :controller do
  describe "#create" do
    let(:chat) { create(:chat) }
    let(:user) { create(:user) }
    let(:content) { "content" }
    let(:serialized_message) do
      {
        created_at: kind_of(String),
        user_email: user.email,
        content: content
      }
    end

    before do
      session[:user_id] = user.id
    end

    it "creates new message" do
      expect(::ChatChannel).to receive(:broadcast_to).with("chat", serialized_message)

      post :create, params: { message: { content: content } }, xhr: true

      expect(response).to have_http_status(:ok)
    end
  end
end

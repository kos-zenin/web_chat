# frozen_string_literal: true

require "rails_helper"

describe MessagesController, type: :controller do
  describe "#create" do
    let(:chat) { create(:chat) }
    let(:user) { create(:user) }
    let(:content) { "content" }

    before do
      session[:user_id] = user.id
    end

    it "creates new message" do
      expect(::NewMessageJob).to receive(:perform_later).with(kind_of(Integer))

      post :create, params: { message: { content: content } }, xhr: true

      expect(response).to have_http_status(:ok)
    end
  end
end

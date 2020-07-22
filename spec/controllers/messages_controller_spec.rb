# frozen_string_literal: true

require "rails_helper"

describe MessagesController, type: :controller do
  describe "#create" do
    let(:chat) { build_stubbed(:chat) }
    let(:user) { build_stubbed(:user) }
    let(:content) { "content" }

    before do
      session[:user_id] = user.id
      expect(User).to receive(:find).with(user.id).and_return(user)

      expect(Chat).to receive(:instance).and_return(chat)
    end

    it "creates new message" do
      expect(chat.messages).to receive(:create).with(user: user, content: content)

      post :create, params: { message: { content: content } }

      expect(response).to have_http_status(:redirect)
      expect(response.redirect_url).to eq("http://test.host/")
    end
  end
end

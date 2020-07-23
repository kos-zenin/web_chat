# frozen_string_literal: true

require "rails_helper"

describe HomeController, type: :controller do
  describe "#index" do
    context "when user isn't authorized" do
      it "redirects to the new session path" do
        get :index

        expect(response).to have_http_status(:redirect)
        expect(response.redirect_url).to eq(["http://test.host", new_sessions_path].join(""))
      end
    end

    context "when user is authorized" do
      let(:user) { build_stubbed(:user) }
      let(:chat) { build_stubbed(:chat) }
      let(:messages) { [build_stubbed(:message)] }
      let(:messages_scope) { class_double(::Message) }
      let(:current_chat) { isntance_double(::CurrentChat, load: chat) }

      before do
        session[:user_id] = user.id

        expect(User).to receive(:find).with(user.id).and_return(user)
        expect(::CurrentChat).to receive(:new).and_return(current_chat)
        expect(chat.messages).to receive(:preload).with(:user).and_return(messages_scope)
        expect(messages_scope).to receive(:order).with(id: :asc).and_return(messages)
      end

      it "successfully renders the page" do
        get :index

        expect(assigns(:chat)).to eq(chat)
        expect(assigns(:messages)).to eq(messages)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

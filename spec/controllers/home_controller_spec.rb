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

      before do
        session[:user_id] = user.id

        expect(User).to receive(:find).with(user.id).and_return(user)
      end

      it "successfully renders the page" do
        get :index

        expect(response).to have_http_status(:ok)
      end
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

describe SessionsController, type: :controller do
  describe "#new" do
    let(:user) { build_stubbed(:user) }

    before do
      expect(User).to receive(:new).and_return(user)
    end

    it "renders login form" do
      get :new

      expect(response).to have_http_status(:ok)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "#create" do
    let(:user) { build_stubbed(:user) }
    let(:password) { "password" }

    context "when passed params are valid" do

      before do
        expect(User).to receive(:find_by).with(email: user.email).and_return(user)
        expect(user).to receive(:authenticate).with(password).and_return(user)
      end

      it "logs in the user and redirects to the home page" do
        post :create, params: { user: { email: user.email, password: password } }

        expect(response).to have_http_status(:redirect)
        expect(response.redirect_url).to eq("http://test.host/")
      end
    end

    context "when passed params are invalid" do
      context "email is unknown" do
        before do
          expect(User).to receive(:find_by).with(email: "invalid_email").and_return(nil)
        end

        it "renders login form with errors" do
          post :create, params: { user: { email: "invalid_email", password: "password" } }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(assigns(:error)).to eq("Unable to log in, check your credentials please")
        end
      end

      context "password is incorrect" do
        before do
          expect(User).to receive(:find_by).with(email: user.email).and_return(user)
          expect(user).to receive(:authenticate).with("invalid password").and_return(nil)
        end

        it "renders login form with errors" do
          post :create, params: { user: { email: user.email, password: "invalid password" } }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(assigns(:error)).to eq("Unable to log in, check your credentials please")
        end
      end
    end
  end

  describe "#destroy" do
    context "when user is logged in" do
      let(:user) { build_stubbed(:user) }

      before do
        session[:user_id] = user.id

        expect(User).to receive(:find).with(user.id).and_return(user)
      end

      it "cleans session" do
        delete :destroy

        expect(session[:user]).to eq(nil)
        expect(response).to have_http_status(:redirect)
        expect(response.redirect_url).to eq(["http://test.host", new_sessions_path].join(""))
      end
    end

    context "when user isn't logged in" do
      it "redirects user to new session path" do
        delete :destroy

        expect(response).to have_http_status(:redirect)
        expect(response.redirect_url).to eq(["http://test.host", new_sessions_path].join(""))
      end
    end
  end
end

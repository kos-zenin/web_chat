# frozen_string_literal: true

require "rails_helper"

describe UsersController, type: :controller do
  describe "#new" do
    let(:user) { build_stubbed(:user) }

    before do
      expect(User).to receive(:new).and_return(user)
    end

    it "renders sign up form" do
      get :new

      expect(response).to have_http_status(:ok)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "#create" do
    context "when passed params are valid" do
      let(:email) { "email@email.com" }
      let(:password) { "password" }

      it "creates new user and redirects to the home page" do
        post :create, params: { user: { email: email, password: password, password_confirmation: password } }

        expect(response).to have_http_status(:redirect)
        expect(response.redirect_url).to eq("http://test.host/")
      end
    end

    context "when passed params are invalid" do
      context "email is mailformed" do
        let(:email) { "123" }
        let(:password) { "123" }

        it "renders sign up form with errors" do
          post :create, params: { user: { email: email, password: password, password_confirmation: password } }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(assigns(:user).errors[:email]).to be_present
        end
      end

      context "user with this email already registered" do
        let(:email) { "email@email.com" }
        let(:password) { "password" }

        before do
          User.create(email: email, password: password, password_confirmation: password)
        end

        it "renders sign up form with errors" do
          post :create, params: { user: { email: email, password: password, password_confirmation: password } }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(assigns(:user).errors[:email]).to be_present
        end
      end

      context "passwords mismatch" do
        let(:email) { "email@email.com" }
        let(:password) { "123" }

        it "renders sign up form with errors" do
          post :create, params: { user: { email: email, password: password, password_confirmation: "111" } }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(assigns(:user).errors[:password_confirmation]).to be_present
        end
      end
    end
  end
end

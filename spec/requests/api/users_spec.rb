require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:admin_user) { create(:user, :admin) }
  let(:regular_user) { create(:user, :user) }
  let!(:users) { create_list(:user, 3) } # Creates 3 users
  let!(:user) { create(:user, email: "test@example.com", password: "password") }

  describe "GET /api/users" do
    it "returns a list of users with the correct size" do
      sign_in admin_user

      get api_users_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(User.count)
    end
  end

  describe "GET /api/users/:id" do
    it "returns a single user" do
      sign_in admin_user

      get api_user_path(user)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["email"]).to eq(user.email)
    end
  end

  describe "POST /api/users" do
    context "when admin user creates a new user" do
      let(:user_params) { { email: "newuser@example.com", password: "password", role: "user" } }

      it "creates a new user" do
        sign_in admin_user

        post api_users_path, params: { user: user_params }
        expect(response).to have_http_status(:created)
        expect(User.last.email).to eq("newuser@example.com")
      end
    end

    context "when regular user tries to create a new user" do
      let(:user_params) { { email: "unauthorized@example.com", password: "password", role: "user" } }

      it "is forbidden" do
        sign_in regular_user

        post api_users_path, params: { user: user_params }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "PUT /api/users/:id" do
    let(:updated_params) { { email: "updated@example.com", password: "newpassword", role: "admin" } }

    context "when admin user updates a user" do
      it "updates the user" do
        sign_in admin_user

        put api_user_path(user), params: { user: updated_params }

        expect(response).to have_http_status(:ok)
        expect(user.reload.email).to eq("updated@example.com")
      end
    end

    context "when regular user tries to update a user" do
      it "is forbidden" do
        sign_in regular_user

        put api_user_path(user), params: { user: updated_params }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "DELETE /api/users/:id" do
    context "when admin user deletes a user" do
      it "deletes the user" do
        sign_in admin_user

        delete api_user_path(user)
        expect(response).to have_http_status(:no_content)
        expect(User.exists?(user.id)).to be_falsey
      end
    end

    context "when regular user tries to delete a user" do
      it "is forbidden" do
        sign_in regular_user

        delete api_user_path(user)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end

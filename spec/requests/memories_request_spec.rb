require 'rails_helper'

RSpec.describe "Memories", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/memories/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/memories/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/memories/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/memories/index"
      expect(response).to have_http_status(:success)
    end
  end

end

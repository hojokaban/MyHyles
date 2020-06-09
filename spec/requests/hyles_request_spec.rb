require 'rails_helper'

RSpec.describe "Hyles", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/hyles/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/hyles/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/hyles/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/hyles/index"
      expect(response).to have_http_status(:success)
    end
  end

end

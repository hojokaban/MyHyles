require 'rails_helper'

RSpec.describe "DailyRelationships", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/daily_relationships/new"
      expect(response).to have_http_status(:success)
    end
  end

end

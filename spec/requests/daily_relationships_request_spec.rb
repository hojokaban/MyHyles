require 'rails_helper'

RSpec.describe "DailyRelationships", type: :request do

  describe "画面に遷移する" do
    it "今日の関係の追加画面が表示される" do
      get new_users_daily_relationship_path
      expect(response).to have_http_status(:success)
    end
  end

end

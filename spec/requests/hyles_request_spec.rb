require 'rails_helper'

RSpec.describe "Hyles", type: :request do

    let(:hyle) { create(:test_hyle)}

    before do
        sign_in hyle.user
    end

  context "画面に遷移する" do
    it "ヒュレー追加画面が表示される" do
      get new_users_hyle_path
      expect(response).to have_http_status(:success)
    end

    it "ヒュレー編集画面が表示される" do
      get edit_users_hyle_path(hyle)
      expect(response).to have_http_status(:success)
    end

    it "ヒュレー詳細画面が表示される" do
      get users_hyle_path(hyle)
      expect(response).to have_http_status(:success)
    end

    it "ヒュレー一覧画面が表示される" do
      get users_hyles_path
      expect(response).to have_http_status(:success)
    end
  end

end

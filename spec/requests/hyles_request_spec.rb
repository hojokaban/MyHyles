require 'rails_helper'

RSpec.describe "Hyles", type: :request do
    let(:user) { create(:test_user) }
    let(:category){create(:test_category, user:user)}
    let!(:hyle) { create(:test_hyle, user:user, category:category) }

    before do
        sign_in user
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

  context "hyleコントローラーの機能" do

    it "ヒュレーが追加できる" do
      expect{
      post users_hyles_path, params:{hyle:{
                            name: "test",
                            category_id: hyle.category.id}}
      }.to change(Hyle, :count).by(1)
    end

  end

end

require 'rails_helper'
include Warden::Test::Helpers

describe 'deviseの統合テスト', type: :system do
    let(:category) { create(:category) }
    let(:user) { category.user }
    before do
        login_as user, scope: :user
    end

    it "設定画面からカテゴリーを追加する" do
        visit edit_user_registration_path
        expect(page).to have_selector 'h3', text: 'カテゴリー'
        expect(page).to have_selector 'span', text: category.name
        #カテゴリーの作成に成功
        fill_in 'category_name', with: "新しいカテゴリー"
        click_button '新しいカテゴリーを追加'
        expect(page).to have_content 'カテゴリーが追加されました'
        expect(page).to have_selector 'span', text: "新しいカテゴリー"
        #カテゴリーの作成に失敗
        fill_in 'category_name', with: "  "
        click_button '新しいカテゴリーを追加'
        expect(page).to have_selector 'li', text: "カテゴリー名を入力してください"
    end
end

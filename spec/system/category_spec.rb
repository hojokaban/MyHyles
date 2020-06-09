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
        within '#add-category' do
            fill_in 'category_name', with: "新しいカテゴリー"
            click_button '新しいカテゴリーを追加'
        end
        expect(page).to have_content 'カテゴリーが追加されました'
    end
end

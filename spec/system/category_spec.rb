require 'rails_helper'
include Warden::Test::Helpers

describe 'deviseの統合テスト', type: :system do
    let(:category) { create(:category) }
    let(:user) { category.user }
    before do
        login_as user, scope: :user
    end

    it "設定画面でカテゴリーを追加、表示、編集、削除する" do
        visit edit_user_registration_path
        expect(page).to have_selector 'h3', text: 'カテゴリー'
        expect(find("#category-name-#{category.id}").value).to eq category.name
        #カテゴリーの作成に失敗
        fill_in 'category_name', with: "  "
        click_button '新しいカテゴリーを追加'
        expect(page).to have_selector 'li', text: "カテゴリー名を入力してください"
        #カテゴリーの作成に成功
        fill_in 'category_name', with: "新しいカテゴリー"
        click_button '新しいカテゴリーを追加'
        expect(page).to have_content 'カテゴリーが追加されました'
        new_category_id = Category.last.id
        expect(find("#category-name-#{new_category_id}").value).to eq "新しいカテゴリー"
        #カテゴリーの編集に失敗
        fill_in "category-name-#{new_category_id}", with: "  "
        find(".edit-category-#{new_category_id}").click
        expect(page).to have_selector 'li', text: "カテゴリー名を入力してください"
        #カテゴリーの編集に成功
        fill_in "category-name-#{new_category_id}", with: "編集したカテゴリー"
        find(".edit-category-#{new_category_id}").click
        expect(page).to have_content "カテゴリーが編集されました"
        expect(find("#category-name-#{new_category_id}").value).to eq "編集したカテゴリー"
    end
end

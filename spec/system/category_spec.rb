require 'rails_helper'
include Warden::Test::Helpers

describe 'categoryの統合テスト', type: :system do
  let(:user) { create(:test_user) }
  let!(:category){create(:test_category, user:user)}
  before do
    login_as user, scope: :user
  end

  it "設定画面でカテゴリーを追加、表示、編集、削除する" do
    visit edit_user_registration_path
    expect(page).to have_selector 'h3', text: 'カテゴリー'
    expect(find("#category-name-#{category.id}").value).to eq category.name
    #カテゴリーの作成に失敗
    fill_in 'new-category', with: "  "
    click_button '新しいカテゴリーを追加'
    sleep 3
    expect(page).to have_selector 'li', text: "カテゴリー名を入力してください" #疑惑1
    #カテゴリーの作成に成功
    fill_in 'new-category', with: "新しいカテゴリー"
    click_button '新しいカテゴリーを追加'
    sleep 2
    expect(page).to have_content 'カテゴリーが追加されました'
    new_category_id = Category.last.id
    expect(find("#category-name-#{new_category_id}").value).to eq "新しいカテゴリー"
    #カテゴリーの編集に失敗
    fill_in "category-name-#{new_category_id}", with: "  "
    find("#edit-category-#{new_category_id}-btn").click
    sleep 2
    expect(page).to have_selector 'li', text: "カテゴリー名を入力してください" #疑惑2
    #カテゴリーの編集に成功
    fill_in "category-name-#{new_category_id}", with: "編集したカテゴリー"
    find("#edit-category-#{new_category_id}-btn").click
    expect(page).to have_content "カテゴリーが編集されました"
    expect(find("#category-name-#{new_category_id}").value).to eq "編集したカテゴリー"
    #カテゴリーの削除に成功
    page.accept_confirm("このカテゴリーを削除すると、このカテゴリーのヒュレーが全て削除されます。本当に削除しますか？") do
      find("#delete-category-#{new_category_id}").click
    end
    expect(page).to have_content "カテゴリーが削除されました"
    expect(page).to have_no_css "#category-name-#{new_category_id}"
  end
end

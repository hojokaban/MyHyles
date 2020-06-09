require 'rails_helper'
include Warden::Test::Helpers

describe 'deviseの統合テスト', type: :system do
    let(:hyle) { create(:test_hyle)}
    let(:user) { hyle.user }
    before do
        login_as user, scope: :user
    end
    context "ヒュレー追加画面" do
      before do
          visit new_users_hyle_path
      end
      it "ヒュレーを追加する" do
          expect(page).to have_selector 'h2', text: 'ヒュレーの追加'
          #ヒュレー情報の入力に失敗(カテゴリーがない)
          fill_in 'hyle_name', with: "新しいヒュレー"
          choose '誕生日を記入しない'
          click_button 'この内容で追加する'
          expect(page).to have_content 'カテゴリーを入力してください'
          #ヒュレー情報の入力に失敗(名前がない)
          fill_in 'hyle_name', with: "  "
          select hyle.category.name, from: 'hyle[category_id]'
          click_button 'この内容で追加する'
          expect(page).to have_content '名前を入力してください'
          #ヒュレー情報の入力に成功
          fill_in 'hyle_name', with: "新しいヒュレー"
          select hyle.category.name, from: 'hyle[category_id]'
          click_button 'この内容で追加する'
          expect(page).to have_content 'ヒュレーが追加されました!'
      end
      it 'カテゴリーを追加する' do
        #カテゴリーの追加に失敗
        fill_in 'category_name', with: "  "
        click_button '新しいカテゴリーを追加'
        expect(page).to have_selector 'li', text: "カテゴリー名を入力してください"
        #カテゴリーの追加に成功
        fill_in 'category_name', with: "新しいカテゴリー"
        click_button '新しいカテゴリーを追加'
        expect(page).to have_content 'カテゴリーが追加されました'
      end
      it 'タグを追加、削除する' do
        #タグの追加に失敗(タグ名が空)
        fill_in 'user_tag', with: " "
        click_button '新しいタグを追加'
        expect(page).to have_content 'タグ名は空白では追加できません'
        user.reload
        expect(user.tag_list.count).to eq 0
        #タグの追加に失敗(タグ名が空)
        fill_in 'user_tag', with: "a"*21
        click_button '新しいタグを追加'
        expect(page).to have_content 'タグ名は20字以内です'
        user.reload
        expect(user.tag_list.count).to eq 0
        #タグの追加に成功
        fill_in 'user_tag', with: "新しいタグ"
        click_button '新しいタグを追加'
        expect(page).to have_content 'タグが追加されました!'
        user.reload
        expect(user.tag_list.count).to eq 1
        #タグを削除する
        click_link "削除"
        expect(page).to have_content 'タグを削除しました'
        user.reload
        expect(user.tag_list.count).to eq 0
      end
    end
end

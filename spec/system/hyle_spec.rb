require 'rails_helper'
include Warden::Test::Helpers

describe 'hylesの統合テスト', type: :system do
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
          select "test_category", from: 'hyle[category_id]'
          click_button 'この内容で追加する'
          expect(page).to have_content '名前を入力してください'
          #ヒュレー情報の入力に成功
          fill_in 'hyle_name', with: "新しいヒュレー"
          select "test_category", from: 'hyle[category_id]'
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
      end
      it 'タグの編集' do
        #タグを３つ追加
        fill_in 'user_tag', with: "タグ1"
        click_button '新しいタグを追加'
        fill_in 'user_tag', with: "タグ2"
        click_button '新しいタグを追加'
        fill_in 'user_tag', with: "タグ3"
        click_button '新しいタグを追加'
        user.reload
        #タグ付けでヒュレーを追加する
        fill_in 'hyle_name', with: "タグ付きヒュレー"
        select "test_category", from: 'hyle[category_id]'
        #expect(find("#hyle_tag_list_callタグ2call").value).to eq '<call>タグ2</call>'
        check user.tag_list[1]
        #"hyle_tag_list_call#{user.tag_list[1]}call"
        check user.tag_list[2]
        click_button 'この内容で追加する'
        expect(page).to have_content 'ヒュレーが追加されました!'
        #詳細ページに遷移し、正しく表示
        expect(page).to have_content "こんな感じー"
        expect(page).to have_selector 'h2', text: "タグ付きヒュレー"
        expect(page).to have_selector 'h4', text: "タグ付きヒュレー"
        expect(page).to have_selector 'h4', text: "test_category"
        expect(page).to have_selector 'span', text: "タグ2"
        expect(page).to have_selector 'span', text: "タグ3"
        expect(page).not_to have_selector 'span', text: "タグ1"
      end
    end
end

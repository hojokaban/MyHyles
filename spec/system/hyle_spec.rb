require 'rails_helper'
include Warden::Test::Helpers

describe 'hylesの統合テスト', type: :system do
    let(:hyle) { create(:test_hyle)}
    let(:user) { hyle.user }
    before do
        login_as user, scope: :user
    end
    context "ヒュレー追加画面から詳細画面" do
      before do
          visit new_users_hyle_path
      end
      it "ヒュレーを誕生日、タグなしで追加する" do
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
          fill_in 'hyle_name', with: "タグなしヒュレー"
          select "test_category", from: 'hyle[category_id]'
          click_button 'この内容で追加する'
          expect(page).to have_content 'ヒュレーが追加されました!'
          #詳細ページに遷移し、正しく表示
          expect(page).to have_selector 'h2', text: "タグなしヒュレー"
          expect(page).to have_selector 'td', text: "タグなしヒュレー"
          expect(page).to have_selector 'td', text: "test_category"
          #タグが表示されない
          expect(page).not_to have_selector 'th', text: "タグ"
          #誕生日が表示されない
          expect(page).not_to have_selector 'th', text: "誕生日"
      end
      it 'カテゴリーを追加する' do
        #カテゴリーの追加に失敗
        fill_in 'category_name', with: "  "
        click_button '新しいカテゴリーを追加'
        expect(page).to have_selector 'li', text: "カテゴリー名を入力してください"
        expect(page).to have_select('hyle[category_id]', options: ["カテゴリーを選択してください", "test_category"])
        #カテゴリーの追加に成功
        fill_in 'category_name', with: "新しいカテゴリー"
        click_button '新しいカテゴリーを追加'
        expect(page).to have_content 'カテゴリーが追加されました'
        expect(page).to have_select('hyle[category_id]', options: ["カテゴリーを選択してください", "test_category", "新しいカテゴリー"])
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
      it '画像を追加する' do
        attach_file 'hyle_hyle_image', "#{Rails.root}/spec/factories/sample1.jpg"
        fill_in 'hyle_name', with: "画像ありヒュレー"
        select "test_category", from: 'hyle[category_id]'
        click_button 'この内容で追加する'
        expect(page).to have_content 'ヒュレーが追加されました!'
        #詳細ページに遷移し、正しく表示
        expect(page).to have_selector 'h2', text: "画像ありヒュレー"
        #expect(page).to have_css "img[src$='sample1.jpg']"
      end
      it 'ヒュレーを誕生日あり、タグ付けで追加する' do
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
        choose '誕生日を記入する'
        select "2016", from: 'hyle[birthday(1i)]'
        select "12", from: 'hyle[birthday(2i)]'
        select "12", from: 'hyle[birthday(3i)]'
        select "test_category", from: 'hyle[category_id]'
        check user.tag_list[1]
        check user.tag_list[2]
        click_button 'この内容で追加する'
        expect(page).to have_content 'ヒュレーが追加されました!'
        #詳細ページに遷移し、正しく表示
        expect(page).to have_selector 'h2', text: "タグ付きヒュレー"
        expect(page).to have_selector 'td', text: "タグ付きヒュレー"
        expect(page).to have_selector 'td', text: "2016-12-12"
        expect(page).to have_selector 'td', text: "test_category"
        expect(page).to have_selector 'span', text: "タグ2"
        expect(page).to have_selector 'span', text: "タグ3"
        expect(page).not_to have_selector 'span', text: "タグ1"
      end
      it 'ラベルを追加して、ヒュレーの追加' do
        #ラベルを追加する
        fill_in 'label_name', with: "テストラベル"
        click_button '新しいラベルを追加'
        expect(page).to have_selector 'label', text: "テストラベル"
      end
    end
end

require 'rails_helper'
include Warden::Test::Helpers

describe 'deviseの統合テスト', type: :system do
    let(:hyle) { create(:test_hyle)}
    let(:user) { hyle.user }
    before do
        login_as user, scope: :user
    end

    it "ヒュレー追加画面" do
        visit new_users_hyle_path
        expect(page).to have_selector 'h2', text: 'ヒュレーの追加'
        #ヒュレー情報の入力に失敗(カテゴリーがない)
        fill_in 'hyle_name', with: "新しいヒュレー"
        choose '誕生日を記入しない'
        click_button 'この内容で追加する'
        expect(page).to have_content 'カテゴリーを入力してください'
    end
end
#select hyle.category, from 'カテゴリー'

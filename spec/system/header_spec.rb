require 'rails_helper'
describe 'ヘッダーのテスト', type: :system do
    before do
        visit root_path
    end

    context "ログインしていない状態" do
        it 'このサイトについてに遷移' do
            click_link 'このサイトについて'
            expect(page).to have_selector 'h2', text: 'アバウトページ'
        end
        it 'ログイン画面に遷移' do
            click_link 'ログイン'
            expect(page).to have_selector 'h2', text: 'ログイン'
        end
        it '新規登録画面に遷移' do
            click_link '新規登録'
            expect(page).to have_selector 'h2', text: '新規登録'
        end
    end

end

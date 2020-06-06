require 'rails_helper'
include Warden::Test::Helpers
describe 'ヘッダーのテスト', type: :system do
    before do
        visit root_path
    end

    context "ログインしていない状態" do
        it 'トップページに遷移' do
            find('.navbar-brand').click
            expect(page).to have_selector 'h2', text: 'トップページです！'
        end
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

    context "ログインしている状態" do
        before do
            @user = create(:user)
            login_as @user, scope: :user
            visit current_path
        end

        it 'ログアウトができる' do
            expect(page).not_to have_selector 'a', text: 'このサイトについて'
            click_link "#{@user.name}さん"
            click_link 'ログアウト'
            expect(page).to have_selector 'a', text: 'このサイトについて'
        end
    end

end

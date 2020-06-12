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
        let(:user) { create(:test_user) }
        before do
            login_as user, scope: :user
            visit current_path
        end
        it 'メインページに遷移' do
            click_link "#{user.name}さん"
            click_link 'メインページ'
            expect(page).to have_selector 'h2', text: 'メインページ'
        end
        it 'ヒュレー一覧画面に遷移' do
          click_link "#{user.name}さん"
          click_link 'ヒュレー'
          expect(page).to have_selector 'h2', text: '全ヒュレー'
        end
        it '思い出一覧画面に遷移' do
          click_link "#{user.name}さん"
          click_link '思い出'
          expect(page).to have_selector 'h2', text: '思い出一覧'
        end
        it '設定画面に遷移' do
            click_link "#{user.name}さん"
            click_link '設定'
            expect(page).to have_selector 'h2', text: '設定画面'
        end
        it 'ログアウトができる' do
            click_link "#{user.name}さん"
            click_link 'ログアウト'
            expect(page).to have_content 'ログアウトしました!'
            expect(page).not_to have_selector 'a', text: "#{user.name}さん"
        end
        it 'ヒュレー追加画面に遷移' do
          click_link "追加"
          click_link 'ヒュレーの追加'
          expect(page).to have_selector 'h2', text: 'ヒュレーの追加'
        end
        it '思い出追加画面に遷移' do
          click_link "追加"
          click_link '思い出の追加'
          expect(page).to have_selector 'h2', text: '思い出の追加'
        end
    end

end

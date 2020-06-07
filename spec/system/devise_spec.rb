require 'rails_helper'
describe 'deviseの統合テスト', type: :system do

    before do
        ActionMailer::Base.deliveries.clear
    end

    context "新規登録前の動き" do
        it '新規登録に成功' do
            visit new_user_registration_path
            #情報を入力する
            fill_in 'user_name', with: "test"
            fill_in 'user_email', with: "test@example.com"
            fill_in 'user_password', with: "password"
            fill_in 'user_password_confirmation', with: "password"
            click_button '新規登録'

            user = User.last
            mail = open_email(user.email)

            #新規登録ボタンを押すとメールが送られる
            mail.to deliver_to(user.email)
            #トップページへの遷移
            expect(page).to have_content 'アカウント有効化用のメールが送信されています'

            #ログインをすると失敗する
            click_link 'ログイン'
            fill_in 'user_email', with: "test@example.com"
            fill_in 'user_password', with: "password"
            click_button 'ログイン'
            expect(page).to have_content '作業を続行するにはアカウントを有効化する必要があります。'
            expect(page).not_to have_selector 'a', text: "#{user.name}さん"

            #メールの表示
            mail.should have_body_text "#{user.name}さん、ようこそ!"
            click_email_link_matching(/http/, mail)
            #アカウントの有効化
            expect(page).to have_content 'メールアドレスが承認されました'

            #ログインが成功する
            fill_in 'user_email', with: "test@example.com"
            fill_in 'user_password', with: "password"
            click_button 'ログイン'
            expect(page).to have_content 'ログインしました!'
            expect(page).to have_selector 'a', text: "#{user.name}さん"
        end
    end

    context "新規登録後の動き" do
        let(:user) { create(:user, :confirmed)}
        before do
            visit new_user_session_path
        end
        it 'ログインに成功' do
            #情報を入力する
            fill_in 'user_email', with: user.email
            fill_in 'user_password', with: user.password
            click_button 'ログイン'
            #ログインすると追加ボタンが表示される
            expect(page).to have_content 'ログインしました!'
            expect(page).to have_selector 'a', text: '追加'
        end
        it 'パスワード再設定' do
            click_link 'パスワードを忘れた方はこちら'
            expect(page).to have_selector 'h2', text: 'パスワードをお忘れですか？'
            fill_in 'user_email', with: user.email
            click_button 'パスワード再設定用のメールを送信'
            #ボタンを押すとメールが送られる
            mail = open_email(user.email)
            mail.to deliver_to(user.email)
            #トップページへの遷移
            expect(page).to have_content 'パスワード再設定についてのメールが送信されます'
            #メールの表示
            mail.should have_body_text "#{user.name}さん、こんにちは!"
            click_email_link_matching(/http/, mail)
            #パスワード編集画面へ遷移
            expect(page).to have_selector 'h2', text: 'パスワードの再設定'
            #パスワードを変更する
            fill_in 'user_password', with: "new_password"
            fill_in 'user_password_confirmation', with: "new_password"
            click_button 'パスワードを変更する'
            #パスワード変更に成功し、ログインされる
            expect(page).to have_content 'パスワードが変更されました。ログイン済みです。'
            expect(page).to have_selector 'a', text: "#{user.name}さん"
        end
    end
end

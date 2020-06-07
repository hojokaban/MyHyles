require 'rails_helper'
describe 'deviseの統合テスト', type: :system do

    context "新規登録機構" do
        let(:user) { build(:user)}
        before do
            ActionMailer::Base.deliveries.clear
        end
        it '新規登録に成功' do
            visit new_user_registration_path
            #情報を入力する
            fill_in 'user_name', with: user.name
            fill_in 'user_email', with: user.email
            fill_in 'user_password', with: user.password
            fill_in 'user_password_confirmation', with: user.password
            #新規登録ボタンを押すとメールが送られる
            expect{click_button '新規登録'}.to change { ActionMailer::Base.deliveries.size }.by(1)
            #トップページへの遷移
            expect(page).to have_content 'アカウント有効化用のメールが送信されています'

            #ログインをすると失敗する
            click_link 'ログイン'
            fill_in 'user_email', with: user.email
            fill_in 'user_password', with: user.password
            click_button 'ログイン'
            expect(page).to have_content '作業を続行するにはアカウントを有効化する必要があります。'
            expect(page).not_to have_selector 'a', text: "#{user.name}さん"

            signed_up_user = User.last
            mail = open_email(signed_up_user.email)
            #メールの表示
            mail.should have_body_text "#{signed_up_user.name}さん、ようこそ!"
            click_email_link_matching(/http/, mail)
            #アカウントの有効化
            expect(page).to have_content 'メールアドレスが承認されました'

            #ログインが成功する
            fill_in 'user_email', with: user.email
            fill_in 'user_password', with: user.password
            click_button 'ログイン'
            expect(page).to have_content 'ログインしました!'
            expect(page).to have_selector 'a', text: "#{user.name}さん"
        end
    end

    context "ログイン機構" do
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
            #ボタンを押すとメールが送られる
            expect{click_button 'パスワード再設定用のメールを送信'}.to change { ActionMailer::Base.deliveries.size }.by(1)
        end
    end
end

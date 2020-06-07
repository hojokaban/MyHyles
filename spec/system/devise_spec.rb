require 'rails_helper'
describe 'deviseの統合テスト', type: :system do

    before do
        ActionMailer::Base.deliveries.clear
        @user = build(:user)
    end

    it '新規登録に成功' do
        visit new_user_registration_path
        #情報を入力する
        fill_in 'user_name', with: @user.name
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        fill_in 'user_password_confirmation', with: @user.password
        expect{click_button '新規登録'}.to change { ActionMailer::Base.deliveries.size }.by(1)
        expect(page).to have_content 'アカウント有効化用のメールが送信されています'

        user = User.last
        token = user.confirmation_token
        mail = open_email(user.email)
        mail.should have_body_text "#{user.name}さん、ようこそ!"
        click_email_link_matching(/http/, mail)
        expect(page).to have_content 'メールアドレスが承認されました'
    end

    context "ログイン機構" do
        before do
            @user.save!
            visit new_user_session_path
        end
        it 'ログインに成功' do
            #情報を入力する
            fill_in 'user_email', with: @user.email
            fill_in 'user_password', with: @user.password
            click_button 'ログイン'
            #ログインすると追加ボタンが表示される
            expect(page).to have_content 'ログインしました!'
            expect(page).to have_selector 'a', text: '追加'
        end
        it 'パスワード再設定' do
            click_link 'パスワードを忘れた方はこちら'
            expect(page).to have_selector 'h2', text: 'パスワードをお忘れですか？'
        end
    end
end

require 'rails_helper'
include Warden::Test::Helpers

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

            #メールの表示
            mail.should have_body_text "#{user.name}さん、ようこそ!"
            #ログインをすると失敗する
            click_link 'ログイン'
            fill_in 'user_email', with: "test@example.com"
            fill_in 'user_password', with: "password"
            click_button 'ログイン'
            expect(page).to have_content '作業を続行するにはアカウントを有効化する必要があります。'
            expect(page).not_to have_selector 'a', text: "#{user.name}さん"
            #アカウント有効化メールの再送信
            click_link '確認メールが届いていない方はこちら'
            expect(page).to have_selector 'h2', text: 'アカウント有効化メールの再送信'
            fill_in 'user_email', with: "test@example.com"
            click_button 'アカウント有効化メールを再送する'
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
        it "新規登録に失敗" do
            visit new_user_registration_path
            #名前とメールアドレスが空で失敗
            fill_in 'user_name', with: "  "
            fill_in 'user_email', with: "  "
            fill_in 'user_password', with: "password"
            fill_in 'user_password_confirmation', with: "password"
            click_button '新規登録'
            expect(page).to have_selector 'li', text: '名前を入力してください'
            expect(page).to have_selector 'li', text: 'メールアドレスを入力してください'
            #パスワードが一致せず失敗
            fill_in 'user_name', with: "test"
            fill_in 'user_email', with: "test@example.com"
            fill_in 'user_password', with: "password"
            fill_in 'user_password_confirmation', with: "other_password"
            click_button '新規登録'
            expect(page).to have_selector 'li', text: 'パスワード（確認用）とパスワードの入力が一致しません'
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
            expect(page).to have_selector 'a', text: "#{user.name}さん"
        end
        it 'ログインに失敗' do
            #情報が空で失敗
            fill_in 'user_email', with: "  "
            fill_in 'user_password', with: "  "
            click_button 'ログイン'
            expect(page).to have_content 'メールアドレス又はパスワードが不当です'
        end
        it 'パスワード再設定' do
            click_link 'パスワードを忘れた方はこちら'
            expect(page).to have_selector 'h2', text: 'パスワードをお忘れですか？'
            #メールアドレス登録に失敗する
            fill_in 'user_email', with: "wrong_email@test.com"
            click_button 'パスワード再設定用のメールを送信'
            expect(page).to have_selector 'li', text: "メールアドレスが見つかりませんでした"
            #メールアドレス登録に成功する
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
            #パスワードの変更に失敗する
            fill_in 'user_password', with: "new_password"
            fill_in 'user_password_confirmation', with: "different_password"
            click_button 'パスワードを変更する'
            expect(page).to have_selector 'li', text: 'パスワード（確認用）とパスワードの入力が一致しません'
            #パスワードを変更する
            fill_in 'user_password', with: "new_password"
            fill_in 'user_password_confirmation', with: "new_password"
            click_button 'パスワードを変更する'
            #パスワード変更に成功し、ログインされる
            expect(page).to have_content 'パスワードが変更されました。ログイン済みです。'
            expect(page).to have_selector 'a', text: "#{user.name}さん"
        end
    end

    context "ログイン後の動き" do
        let(:user) { create(:user, :confirmed)}
        before do
            login_as user, scope: :user
        end
        it '設定画面' do
            visit edit_user_registration_path
            #ユーザー情報の編集に成功
            within '.edit-user' do
                fill_in 'user_name', with: "変更した名前"
                fill_in 'user_email', with: "changed@mail.com"
                fill_in 'user_password', with: "different"
                fill_in 'user_password_confirmation', with: "different"
                #fill_in 'user_current_password', with: "password"
                click_button '変更を保存する'
            end
            expect(page).to have_content 'アカウントが更新されました'
            #ユーザー情報の編集、パスワードが合っていない
            within '.edit-user' do
                fill_in 'user_name', with: "変更した名前"
                fill_in 'user_email', with: "changed@mail.com"
                fill_in 'user_password', with: "different"
                fill_in 'user_password_confirmation', with: "difficult"
                #fill_in 'user_current_password', with: "password"
                click_button '変更を保存する'
            end
            expect(page).to have_selector 'li', text: 'パスワード（確認用）とパスワードの入力が一致しません'
            #ユーザー情報の編集、片方のパスワードのみ入力されている
            within '.edit-user' do
                fill_in 'user_name', with: "変更した名前"
                fill_in 'user_email', with: "changed@mail.com"
                fill_in 'user_password', with: "different"
                fill_in 'user_password_confirmation', with: "  "
                click_button '変更を保存する'
            end
            expect(page).to have_selector 'li', text: 'パスワード（確認用）とパスワードの入力が一致しません'
            #誕生日の通知情報の編集に成功
            within '.edit-birthday' do
                fill_in 'user_notice_before', with: 12
                click_button '変更を保存する'
            end
            expect(page).to have_content 'アカウントが更新されました'
            #誕生日の通知情報の編集に失敗
            within '.edit-birthday' do
                fill_in 'user_notice_before', with: 366
                click_button '変更を保存する'
            end
            expect(page).to have_content '誕生日の通知の設定は366より小さい値にしてください'
            #関係の期間情報の編集に成功
            within '.edit-frequency' do
                fill_in 'user_term', with: 12
                click_button '変更を保存する'
            end
            expect(page).to have_content 'アカウントが更新されました'
            #関係の期間情報の編集に失敗
            within '.edit-frequency' do
                fill_in 'user_term', with: 121
                click_button '変更を保存する'
            end
            expect(page).to have_content '関係性を算出する期間の設定は121より小さい値にしてください'
        end
    end
end

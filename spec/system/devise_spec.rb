require 'rails_helper'
include Warden::Test::Helpers

describe 'deviseの統合テスト', type: :system do
  let(:user) { create(:test_user) }
    before do
      ActionMailer::Base.deliveries.clear
    end
    context "新規登録前の動き" do
      it '新規登録に成功' do
          visit new_user_registration_path
          #情報を入力する
          fill_in 'user_name', with: "test"
          fill_in 'user_email', with: "testtest@example.com"
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
          mail.to deliver_to(user.email)
          mail.should have_body_text "#{user.name}さん、ようこそ!"
          #ログインをすると失敗する
          click_link 'ログイン'
          fill_in 'user_email', with: "testtest@example.com"
          fill_in 'user_password', with: "password"
          click_button 'ログイン'
          expect(page).to have_content '作業を続行するにはアカウントを有効化する必要があります。'
          expect(page).not_to have_selector 'a', text: "#{user.name}さん"
          #アカウント有効化メールの再送信
          click_link '確認メールが届いていない方はこちら'
          expect(page).to have_selector 'h2', text: 'アカウント有効化メールの再送信'
          fill_in 'user_email', with: "testtest@example.com"
          click_button 'アカウント有効化メールを再送する'
          #メールの表示
          mail.to deliver_to(user.email)
          mail.should have_body_text "#{user.name}さん、ようこそ!"
          click_email_link_matching(/http/, mail)
          #アカウントの有効化
          expect(page).to have_content 'メールアドレスが承認されました'
          #ログインが成功する
          fill_in 'user_email', with: "testtest@example.com"
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

    context "ログイン後の動き(設定画面)" do
      before do
        login_as user, scope: :user
        visit edit_user_registration_path
      end
      it 'ユーザー情報の編集' do
        #ユーザー情報の編集に成功
        fill_in 'user_name', with: "変更した名前"
        fill_in 'user_email', with: "changed@mail.com"
        fill_in 'user_password', with: "different"
        fill_in 'user_password_confirmation', with: "different"
        fill_in 'user_current_password', with: "password"
        click_button '変更を保存する', match: :first
        expect(page).to have_content 'アカウントが更新されました'
        #ユーザー情報の編集、パスワードが合っていない
        fill_in 'user_name', with: "変更した名前"
        fill_in 'user_email', with: "changed@mail.com"
        fill_in 'user_password', with: "different"
        fill_in 'user_password_confirmation', with: "difficult"
        fill_in 'user_current_password', with: "password"
        click_button '変更を保存する', match: :first
        expect(page).to have_selector 'li', text: 'パスワード（確認用）とパスワードの入力が一致しません'
        #ユーザー情報の編集、片方のパスワードのみ入力されている
        fill_in 'user_name', with: "変更した名前"
        fill_in 'user_email', with: "changed@mail.com"
        fill_in 'user_password', with: "different"
        fill_in 'user_password_confirmation', with: "  "
        click_button '変更を保存する', match: :first
        expect(page).to have_selector 'li', text: 'パスワード（確認用）とパスワードの入力が一致しません'
        #ユーザー情報の編集、現在のパスワードがない
        fill_in 'user_name', with: "変更した名前"
        fill_in 'user_email', with: "changed@mail.com"
        fill_in 'user_password', with: "different"
        fill_in 'user_password_confirmation', with: "difficult"
        click_button '変更を保存する', match: :first
        expect(page).to have_selector 'li', text: '現在のパスワードを入力してください'
      end
      it '誕生日の通知情報の編集' do
        #誕生日の通知情報の編集に失敗
        fill_in 'user_notice_before', with: ""
        click_button '変更を保存する', match: :first
        expect(page).to have_content '誕生日の通知の設定を入力してください'
        #誕生日の通知情報の編集に失敗
        fill_in 'user_notice_before', with: 366
        click_button '変更を保存する', match: :first
        expect(page).to have_content '誕生日の通知の設定は366より小さい値にしてください'
        #誕生日の通知情報の編集に成功
        choose '通知を出す'
        fill_in 'user_notice_before', with: 12
        click_button '変更を保存する', match: :first
        expect(page).to have_content 'アカウントが更新されました'
      end
      it '関係の期間情報の編集' do
        #関係の期間情報の編集に失敗
        fill_in 'user_term', with: ""
        click_button '変更を保存する', match: :first
        expect(page).to have_content '関係性を算出する期間の設定を入力してください'
        #関係の期間情報の編集に失敗
        fill_in 'user_term', with: 121
        click_button '変更を保存する', match: :first
        expect(page).to have_content '関係性を算出する期間の設定は121より小さい値にしてください'
        #関係の期間情報の編集に成功
        fill_in 'user_term', with: 12
        click_button '変更を保存する', match: :first
        expect(page).to have_content 'アカウントが更新されました'
      end
      it 'タグの追加と削除' do
        #タグの表示
        expect(page).to have_selector 'span', text: 'tag1'
        expect(page).to have_selector 'span', text: 'tag2'
        expect(page).to have_selector 'span', text: 'tag3'
        #タグの削除
        find("#delete-0").click
        expect(page).to have_content 'タグが削除されました'
        #タグの追加
        fill_in "user_tag", with: "tag4"
        click_button '新しいタグを追加'
        expect(page).to have_content 'タグが追加されました'
        #表示される
        expect(page).to have_selector 'span', text: 'tag4'
        expect(page).to have_selector 'span', text: 'tag2'
        expect(page).to have_selector 'span', text: 'tag3'
      end
    end
end

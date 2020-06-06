require 'rails_helper'
describe 'deviseの統合テスト', type: :system do

    before do
        @user = build(:user)
    end

    it '新規登録に成功' do
        visit new_user_registration_path
        #情報を入力する
        fill_in 'user_name', with: @user.name
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        fill_in 'user_password_confirmation', with: @user.password
        expect{click_button '新規登録'}.to change(User, :count).by(1)

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
            visit current_path
            #ログインすると追加ボタンが表示される
            expect(page).to have_selector 'a', text: '追加'
        end
        it 'パスワード再設定' do
            click_link 'パスワードを忘れた方はこちら'
            expect(page).to have_selector 'h2', text: 'パスワードをお忘れですか？'
        end
    end
end

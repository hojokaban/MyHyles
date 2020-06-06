require 'rails_helper'
describe 'deviseの統合テスト', type: :system do
#describe 'deviseの統合テスト' do

    before do
        @user = build(:user)
    end

    it '新規登録に成功' do
        #新規登録画面へ移動
        visit new_user_registration_path
        #情報を入力する
        fill_in 'user_name', with: @user.name
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        fill_in 'user_password_confirmation', with: @user.password

        expect{click_button '新規登録'}.to change(User, :count).by(1)

    end
end

require 'rails_helper'

describe "devise関連" do

    context "画面に遷移する" do
        it '新規登録画面が表示される' do
            get new_user_registration_path
            expect(response.status).to eq 200
        end

        it 'ログイン画面が表示される' do
            get new_user_session_path
            expect(response.status).to eq 200
        end
        it 'パスワード再設定メール送信画面が表示される' do
            get new_user_password_path
            expect(response.status).to eq 200            
        end
    end

    context "新規ユーザーが登録機能" do
        it '正しく登録される' do
             expect{
                  post user_registration_path, params: {user: attributes_for(:user)}
             }.to change(User, :count).by(1)
             #登録後はトップページへリダイレクトされる
             expect(response).to redirect_to(root_path)
        end
    end
    context "ログイン機能" do
        before do
            @user = create(:user)
        end
        it '正しくログインされる' do
            post user_session_path, params: {user: {email: @user.email,
                                                    password: @user.password}}
            #トップページへリダイレクトされる
            expect(response.status).to eq 302
            expect(response).to redirect_to(root_path)
        end
        it '正しくログアウトされる' do
            sign_in @user
            delete destroy_user_session_path(@user)
            expect(response.status).to eq 204
        end
    end
end

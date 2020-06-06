require 'rails_helper'

describe "devise関連の画面" do
    context "新規登録画面が表示される" do
        it 'リクエストは200 OKとなること' do
            get new_user_registration_path
            expect(response.status).to eq 200
        end
    end
    context "ログイン画面が表示される" do
        it 'リクエストは200 OKとなること' do
            get new_user_session_path
            expect(response.status).to eq 200
        end
    end
end

describe "devise機能" do
    context "新規ユーザーが登録される" do
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

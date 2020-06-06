require 'rails_helper'

describe 'devise関連の画面' do
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

describe 'devise機能' do
    context "新規ユーザーが登録される" do
        it '正しく登録される' do
             expect{
                  post user_registration_path, params: {user: attributes_for(:user)}
             }.to change(User, :count).by(1)
             #登録後はトップページへリダイレクトされる
             expect(response).to redirect_to(root_path)
        end
    end
end

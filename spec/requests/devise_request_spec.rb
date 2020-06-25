require 'rails_helper'

describe "devise関連", type: :request do

  context "画面に遷移する" do
    it '新規登録画面が表示される' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
    it 'ログイン画面が表示される' do
      get new_user_session_path
      expect(response).to have_http_status(:success)
    end
    it 'パスワード再設定メール送信画面が表示される' do
      get new_user_password_path
      expect(response).to have_http_status(:success)
    end
    it '設定画面が表示される' do
      get edit_user_registration_path
      expect(response.status).to eq 302
    end
  end

  context "registrationコントローラーの機能" do
    it '正しく登録される' do
       expect{
            post user_registration_path, params: {user: attributes_for(:user)}
       }.to change(User, :count).by(1)
       #登録後はトップページへリダイレクトされる
       expect(response).to redirect_to(root_path)
    end
    context "ユーザーの編集について" do
      let(:user) { create(:test_user) }
      before do
        sign_in user
      end
      it 'タグの追加と削除' do
        #追加
        expect(user.tag_list.count).to eq 3
        patch tag_registration_path, xhr: true, params:{user:{tag:"test"}}
        expect(user.reload.tag_list.count).to eq 4
        #削除
        delete user_registration_path("test")
        expect(user.reload.tag_list.count).to eq 3
      end
    end
  end
  context "sessionコントローラーの機能" do
    let(:user){create(:test_user)}
    it '正しくログインされる' do
      post user_session_path, params: {user: {email: user.email,
                                              password: user.password}}
      #メインページへリダイレクトされる
      expect(response.status).to eq 302
      expect(response).to redirect_to(users_path)
    end
    it '正しくログアウトされる' do
      sign_in user
      delete destroy_user_session_path(user)
      expect(response.status).to eq 204
    end
  end
end

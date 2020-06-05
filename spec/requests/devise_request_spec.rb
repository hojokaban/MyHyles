require 'rails_helper'
RSpec.describe "Devises", type: :request do
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

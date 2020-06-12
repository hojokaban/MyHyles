require 'rails_helper'

describe "Users関連" do
  context "画面に遷移する" do
    before do
      sign_in create(:user)
    end
    it 'メインページが表示される' do
      get users_path
      expect(response.status).to eq 302
    end
  end
end

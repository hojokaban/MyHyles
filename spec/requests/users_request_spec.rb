require 'rails_helper'

describe "Users関連" do
  context "画面に遷移する" do
    let(:user){create(:user)}
    before do
      sign_in user
    end
    it 'メインページが表示される' do
      get users_path(user)
      expect(response.status).to eq 302
    end
  end
end

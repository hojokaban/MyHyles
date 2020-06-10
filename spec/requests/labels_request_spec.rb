require 'rails_helper'

RSpec.describe "Labels", type: :request do
  let(:user) { create(:test_user) }
  before do
    sign_in user
  end
  it 'ラベル作成画面に遷移' do
    get new_users_label_path
    expect(response).to have_http_status(:success)
  end
end

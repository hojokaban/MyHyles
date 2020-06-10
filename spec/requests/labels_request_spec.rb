require 'rails_helper'

RSpec.describe "Labels", type: :request do
  let(:hyle) { create(:test_hyle) }
  before do
    sign_in hyle.user
  end
  it 'ラベル作成画面に遷移' do
    get edit_users_label_path(hyle)
    expect(response).to have_http_status(:success)
  end
end

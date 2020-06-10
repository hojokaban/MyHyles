require 'rails_helper'

RSpec.describe "Labels", type: :request do
  let(:label) { create(:test_label) }
  before do
    sign_in label.user
  end
  it 'ラベル作成画面に遷移' do
    get edit_users_label_path(label.hyle)
    expect(response).to have_http_status(:success)
  end
  it 'ラベル作成ができる' do
    expect{
      post users_labels_path, params:{label:{
        name: "test",
        body: "test body",
        hyle_id: label.hyle.id
        }}
    }.to change(Label, :count).by(1)
  end
  it 'ラベルが編集できる' do
    patch users_label_path(label), params:{label:{
      name: "editted test",
      body: "editted test body",
      }}
    label.reload
    expect(label.name).to eq "editted test"
    expect(label.body).to eq "editted test body"
  end
  it 'ラベルが削除できる' do
    expect{
      delete users_label_path(label)
    }.to change(Label, :count).by(-1)
  end
end

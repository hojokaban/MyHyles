require 'rails_helper'

RSpec.describe "Memories", type: :request do
  let(:user) { create(:test_user) }
  let!(:memory) {create(:test_memory, user:user)}
  before do
    sign_in user
  end
  context "画面に遷移する" do
    it "思い出追加画面が表示される" do
      patch new_users_memory_path
      expect(response).to have_http_status(:success)
    end
    it "思い出詳細画面が表示される" do
      get users_memory_path(memory)
      expect(response).to have_http_status(:success)
    end
    it "思い出編集画面が表示される" do
      get edit_users_memory_path(memory)
      expect(response).to have_http_status(:success)
    end
    it "思い出一覧画面が表示される" do
      get users_memories_path
      expect(response).to have_http_status(:success)
    end
  end
  context "memory機能" do
    it "思い出が追加される" do
      expect{
        post users_memories_path, params: { memory: {title: "test"}}
      }.to change(Memory, :count).by(1)
    end
    it '思い出が編集される' do
      expect(memory.title).to eq memory.title
      patch users_memory_path(memory), params: {memory: {title: "editted"}}
      expect(memory.reload.title).to eq "editted"
    end
    it '思い出が削除される' do
      expect{
        delete users_memory_path(memory)
      }.to change(Memory, :count).by(-1)
    end
  end
end








it "こんなテスト" do
  expect(これが).to これになる
  patch users_path(user), params:{user:}
  expect(user.name).to eq "よっしー"
end

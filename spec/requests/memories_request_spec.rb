require 'rails_helper'

RSpec.describe "Memories", type: :request do

  let(:memory) {create(:test_memory)}

  describe "画面に遷移する" do
    it "思い出追加画面が表示される" do
      get new_users_memory_path
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
end

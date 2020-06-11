require 'rails_helper'
include Warden::Test::Helpers

describe 'memoriesの統合テスト', type: :system do
  let(:hyle_memory) { create(:hyle_memory) }
  let(:hyle) { hyle_memory.hyle}
  let(:user) { hyle.user }
  let(:memory) {hyle_memory.memory}
  before do
    memory.update(user: user)
    login_as user, scope: :user
  end
  it '思い出追加画面' do
    visit new_users_memory_path
    binding.pry
  end
end

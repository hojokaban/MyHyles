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
    expect(page).to have_selector 'h2', text: "思い出の追加"
    #思い出の追加に失敗
    fill_in 'memory-title', with: "a"*21
    click_button 'この内容で追加する'
    expect(page).to have_selector 'h2', text: 'タイトルは20字以下'
    #思い出の追加に成功
    fill_in 'memory-title', with: "test memory"
    click_button 'この内容で追加する'
    expect(page).to have_content '思い出を追加しました!'
  end
end

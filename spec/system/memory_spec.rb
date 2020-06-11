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
    fill_in 'new-memory-title', with: "a"*21
    click_button 'この内容で追加する'
    expect(page).to have_selector 'li', text: 'タイトルは20文字以内で入力してください'
    #思い出の追加に成功
    fill_in 'new-memory-title', with: "test memory"
    click_button 'この内容で追加する'
    expect(page).to have_content '思い出が追加されました!'
    #詳細画面に表示
    expect(page).to have_selector 'h2', text: "test memory"
    expect(page).to have_selector 'td', text: "test memory"
  end
  # it 'ヒュレーと思い出追加画面' do
  #   visit new_users_memory_path
  #   fill_in 'new-memory-title', with: "test memory"
  #   check user.tag_list[1]
  #   check user.tag_list[2]
  #   click_button 'この内容で追加する'
  #   expect(page).to have_content '思い出が追加されました!'
  # end
end

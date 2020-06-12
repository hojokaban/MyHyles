require 'rails_helper'
include Warden::Test::Helpers

describe 'memoriesの統合テスト', type: :system do
  let(:user) { create(:test_user)}
  let(:category) { create(:category, user:user)}
  let(:hyle) { create(:test_hyle, user: user, category:category)}
  let(:memory) {create(:test_memory, user: user)}
  let(:hyle_memory) { create(:hyle_memory, hyle:hyle, memory:memory) }
  before do
    login_as user, scope: :user
  end
  it '思い出追加画面' do
    visit new_users_memory_path
    expect(page).to have_selector 'h2', text: "思い出の追加"
    #思い出の追加に失敗
    fill_in 'memory-title', with: "a"*21
    click_button 'この内容で追加する'
    expect(page).to have_selector 'li', text: 'タイトルは20文字以内で入力してください'
    #思い出の追加に成功
    fill_in 'memory-title', with: "test memory"
    click_button 'この内容で追加する'
    expect(page).to have_content '思い出が追加されました!'
    #詳細画面に表示
    expect(page).to have_selector 'h2', text: "test memory"
    expect(page).to have_selector 'td', text: "test memory"
  end
  it 'ヒュレーをチェックして思い出追加、編集、削除ができる' do
    hyle2 = create(:hyle, user:user, category:category)
    hyle3 = create(:hyle, user:user, category:category)
    visit new_users_memory_path
    fill_in 'memory-title', with: "test memory"
    check hyle2.name
    check hyle3.name
    click_button 'この内容で追加する'
    expect(page).to have_content '思い出が追加されました!'
    #詳細画面に遷移し、表示される
    expect(page).to have_selector 'td', text: "test memory"
    expect(page).to have_selector 'td', text: hyle2.name
    expect(page).to have_selector 'td', text: hyle3.name
    expect(page).not_to have_selector 'td', text: hyle.name
    #編集画面へ遷移
    click_link '内容を編集する'
    expect(page).to have_selector 'h2', text: "思い出の編集"
    # expect(page).to have_checked_field(hyle2.name)
    # expect(page).not_to have_checked_field(hyle.name)
    #編集に失敗
    fill_in 'memory-title', with: "a"*21
    click_button '変更を保存する'
    expect(page).to have_selector 'li', text: 'タイトルは20文字以内で入力してください'
    #思い出の編集に成功
    fill_in 'memory-title', with: "editted memory"
    check hyle.name
    check hyle2.name
    click_button '変更を保存する'
    expect(page).to have_content '思い出が編集されました!'
    #詳細画面に表示
    expect(page).to have_selector 'td', text: "editted memory"
    expect(page).to have_selector 'td', text: hyle.name
    expect(page).to have_selector 'td', text: hyle2.name
    expect(page).not_to have_selector 'td', text: hyle3.name
    #チェックせずに編集(params[:memory][:hyle_ids]がnilとなる)
    click_link '内容を編集する'
    fill_in 'memory-title', with: "editted memory２"
    click_button '変更を保存する'
    expect(page).to have_content '思い出が編集されました!'
    #詳細画面に表示
    expect(page).to have_selector 'td', text: "editted memory２"
    expect(page).not_to have_selector 'td', text: hyle.name
    expect(page).not_to have_selector 'td', text: hyle2.name
    expect(page).not_to have_selector 'td', text: hyle3.name
    #思い出を削除する
    click_button '削除する'
    accept_alert
    expect(page).to have_content "思い出が削除されました"
    expect(page).to have_selector 'h2', text: 'メインページ'
  end
end

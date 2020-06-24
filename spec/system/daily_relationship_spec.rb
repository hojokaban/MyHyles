require 'rails_helper'
include Warden::Test::Helpers

describe 'hyle_daily_relationshipsの統合テスト', type: :system do
  let(:user) { create(:test_user) }
  let(:category){create(:test_category, user:user)}
  let!(:hyle){create(:test_hyle, user:user, category:category)}
  let(:daily_relationship){create(:daily_relationship, user:user)}
  let!(:another_hyle){create(:hyle, user:user, category:category)}
  before do
      login_as user, scope: :user
  end
  it "今日の関係追加画面" do
    visit new_users_daily_relationship_path
    expect(page).to have_selector 'h2', text: Time.current.strftime("%Y年%-m月%-d日")
    expect(page).to have_selector 'h2', text: '今日関わった人間関係を記録しましょう'
    #関係の作成に失敗
    page.accept_confirm("この内容はあとで変更ができません。この内容で追加してもよろしいですか？") do
      click_link 'この内容で追加する'
    end
    #ヒュレー関係の追加に失敗(ヒュレーを選ばない)
    fill_in "hyle_daily_relationship_relationship_amount", with: 60
    expect(page).to have_content "ヒュレーを最低１人追加してください"
    click_button 'このヒュレーを追加する'
    expect(page).to have_selector 'li', text: "ヒュレーを入力してください"
    #ヒュレー関係の追加に失敗(数値を入れない)
    select "test_hyle", from: 'hyle_daily_relationship[hyle_id]'
    fill_in "hyle_daily_relationship_relationship_amount", with: ""
    click_button 'このヒュレーを追加する'
    expect(page).to have_selector 'li', text: "ヒュレーとの関わりを入力してください"
    #ヒュレー関係の追加に成功
    select "test_hyle", from: 'hyle_daily_relationship[hyle_id]'
    fill_in "hyle_daily_relationship_relationship_amount", with: 60
    click_button 'このヒュレーを追加する'
    expect(page).to have_selector 'td', text: "test_hyle"
    expect(page).to have_selector 'td', text: 60
    #同じヒュレーを追加できない
    select "test_hyle", from: 'hyle_daily_relationship[hyle_id]'
    fill_in "hyle_daily_relationship_relationship_amount", with: 40
    click_button 'このヒュレーを追加する'
    expect(page).to have_content "このヒュレーはすでに存在します"
    #ヒュレーを追加して削除する
    select another_hyle.name, from: 'hyle_daily_relationship[hyle_id]'
    fill_in "hyle_daily_relationship_relationship_amount", with: 50
    click_button 'このヒュレーを追加する'
    relation = HyleDailyRelationship.last
    expect(page).to have_selector 'td', text: another_hyle.name
    find("#delete-hyle-#{relation.id}").click
    expect(page).to have_content 'ヒュレーを削除しました'
    expect(page).not_to have_selector 'td', text: another_hyle.name
    #関係の作成に成功
    page.accept_confirm("この内容はあとで変更ができません。この内容で追加してもよろしいですか？") do
      click_link 'この内容で追加する'
    end
    expect(page).to have_content '今日の関係が追加されました!'
    expect(page).to have_selector 'h2', text: 'メインページ'
  end
end

require 'rails_helper'
include Warden::Test::Helpers

describe 'hylesの統合テスト', type: :system do
    let(:user) { create(:test_user) }
    let(:category){create(:test_category, user:user)}
    let(:hyle){create(:test_hyle, user:user, category:category)}
    let(:daily_relationship){create(:daily_relationship, user:user)}
    let(:another_hyle){create(:hyle, user:user, category:category)}
    before do
        login_as user, scope: :user
    end
    it "今日の関係追加画面" do
      visit new_users_daily_relationships_path
      expect(page).to have_selector 'h2', Time.current.strftime("%Y年%-m月%-d日")
      expect(page).to have_selector 'h2', '今日関わった人間関係を記録しましょう'
      #関係の作成に失敗
      click_button 'この内容で追加する'
      accept_alert
      expect(page).to have_selector 'li', 'ヒュレーを入力してください'
      #ヒュレー関係の追加に失敗(ヒュレーを選ばない)
      fill_in "add-relationship", with: 60
      click_button 'このヒュレーを追加する'
      expect(page).to have_selector 'li', text: "ヒュレーとの関わりを入力してください"
      #ヒュレー関係の追加に失敗(数値を入れない)
      select "test_hyle", from: 'user[hyle_id]'
      fill_in "add-relationship", with: ""
      click_button 'このヒュレーを追加する'
      expect(page).to have_selector 'li', text: "ヒュレーを選択してください"
      #ヒュレー関係の追加に成功
      select "test_hyle", from: 'user[hyle_id]'
      fill_in "add-relationship", with: 60
      click_button 'このヒュレーを追加する'
      relation = HyleDailyRelationship.last
      expect(find("#hyle-#{relation.id}").value).to eq "test_hyle"
      expect(find("#amount-#{relation.id}").value).to eq 60
      #同じヒュレーを追加できない
      select "test_hyle", from: 'user[hyle_id]'
      fill_in "add-relationship", with: 40
      click_button 'このヒュレーを追加する'
      expect(page).to have_selector 'li', text: "このヒュレーはすでに存在します"
      #ヒュレーを追加して削除する
      select another_hyle.name, from: 'user[hyle_id]'
      fill_in "add-relationship", with: 50
      click_button 'このヒュレーを追加する'
      new_relation = HyleDailyRelationship.last
      expect(find("#hyle-#{new_relation.id}").value).to eq "another_hyle"
      find("#hyle-#{new_relation.id}").click
      expect(page).to have_content 'ヒュレーを削除しました'
      expect(find("#hyle-#{new_relation.id}").value).not_to eq "another_hyle"
      #関係の作成に成功
      click_button 'この内容で追加する'
      accept_alert
      expect(page).to have_content '今日の関係が追加されました!'
      expect(page).to have_selector 'h2', 'メインページ'
    end
end

require 'rails_helper'
include Warden::Test::Helpers

describe 'hylesの統合テスト', type: :system do
    let(:user) { create(:test_user) }
    let(:category){create(:test_category, user:user)}
    let(:hyle){create(:test_hyle, user:user, category:category)}
    let(:daily_relationship){create(:daily_relationship, user:user)}
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
      #関係の作成に成功
      click_button 'この内容で追加する'
      accept_alert
      expect(page).to have_content '今日の関係が追加されました!'
      expect(page).to have_selector 'h2', 'メインページ'
    end
end

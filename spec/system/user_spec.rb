require 'rails_helper'
include Warden::Test::Helpers

describe 'userの統合テスト', type: :system do
  let(:user) { create(:test_user) }
  let!(:category){create(:test_category, user:user)}
  let(:hyle) { create(:test_hyle, user:user, category:category) }
  let(:label) {create(:test_label, user:user, hyle:hyle)}
  before do
      login_as user, scope: :user
  end
  it "メインページ" do
      visit users_path
      expect(page).to have_selector 'h2', text: 'メインページ'
      #ヒュレーの人数が表示される
      expect(page).to have_selector 'h4', text: user.hyles.count
      #カテゴリーが表示される
      expect(page).to have_selector 'h3', text: "カテゴリー"
      expect(page).to have_selector 'span', text: "test_category"
      #タグが表示される
      expect(page).to have_selector 'h3', text: "タグ"
      expect(page).to have_selector 'span', text: "tag1"
      expect(page).to have_selector 'span', text: "tag2"
      expect(page).to have_selector 'span', text: "tag3"
      #関係記入画面に移動
      click_link "関係の記入画面に移動する"
      expect(page).to have_selector 'h2', text: "今日関わった人間関係を記録しましょう"
  end
end

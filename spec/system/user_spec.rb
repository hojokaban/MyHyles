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
  context "誕生日に関するテスト" do
    let!(:birthday_1204){create(:hyle, user:user, category:category, birthday:Date.parse('1990-12-4'), birthday_date:"1204")}
    let!(:birthday_1205){create(:hyle, user:user, category:category, birthday:Date.parse('1990-12-5'), birthday_date:"1205")}
    let!(:birthday_0120){create(:hyle, user:user, category:category, birthday:Date.parse('1990-1-20'), birthday_date:"0120")}
    it "誕生日の近いヒュレーの期間を設定" do
      travel_to('2020-12-1 0:00'.to_time) do
        expect(Time.zone.now).to eq(Time.new(2020, 12, 1, 0, 0, 0))
        #設定がデフォルトの3日の場合
        visit users_path
        expect(page).to have_selector 'h4', text: birthday_1204.name
        expect(page).not_to have_selector 'h4', text: birthday_1205.name
        expect(page).not_to have_selector 'h4', text: birthday_0120.name
        #設定を50に変更
        visit edit_user_registration_path
        fill_in 'user_notice_before', with: 50
        click_button '変更を保存する', match: :first
        visit users_path
        expect(page).to have_selector 'h4', text: birthday_1204.name
        expect(page).to have_selector 'h4', text: birthday_1205.name
        expect(page).to have_selector 'h4', text: birthday_0120.name
      end
    end
  end
end

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
        within '.birthday-hyle-index' do
          expect(page).to have_selector 'h4', text: birthday_1204.name
          expect(page).not_to have_selector 'h4', text: birthday_1205.name
          expect(page).not_to have_selector 'h4', text: birthday_0120.name
        end
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
  context "関係に関するテスト" do
    let!(:top_relationship){create(:hyle, user:user, category:category, total_relationship:100)}
    let!(:second_relationship){create(:hyle, user:user, category:category, total_relationship:70)}
    let!(:third_relationship){create(:hyle, user:user, category:category, total_relationship:50)}
    let!(:forth_relationship){create(:hyle, user:user, category:category, total_relationship:0)}
    let!(:daily_relationship){create(:daily_relationship, user:user, created_at:1.day.ago)}
    let!(:hyle_daily_relationship1){create(:hyle_daily_relationship, hyle:top_relationship,daily_relationship:daily_relationship, relationship_amount:100)}
    let!(:hyle_daily_relationship2){create(:hyle_daily_relationship, hyle:second_relationship,daily_relationship:daily_relationship, relationship_amount:70)}
    let!(:hyle_daily_relationship3){create(:hyle_daily_relationship, hyle:third_relationship,daily_relationship:daily_relationship, relationship_amount:50)}
    it "ランキングが表示される" do
      visit users_path
      #上位3人が表示される
      within '.relationship-hyle-index' do
        expect(page).to have_selector 'h4', text: top_relationship.name
        expect(page).to have_selector 'h4', text: second_relationship.name
        expect(page).to have_selector 'h4', text: third_relationship.name
        expect(page).not_to have_selector 'h4', text: forth_relationship.name
      end
      #forth_relationshipの関係性を３位にする
      click_link "関係の記入画面に移動する"
      select forth_relationship.name, from: 'hyle_daily_relationship[hyle_id]' #たまにエラー出るけど連続で実行すれば通る
      fill_in "hyle_daily_relationship_relationship_amount", with: 100
      click_button 'このヒュレーを追加する'
      page.accept_confirm("この内容はあとで変更ができません。この内容で追加してもよろしいですか？") do
        click_link 'この内容で追加する'
      end
      top_relationship.reload
      second_relationship.reload
      third_relationship.reload
      forth_relationship.reload
      #上位3人が表示される
      within '.relationship-hyle-index' do
        expect(page).to have_selector 'h4', text: top_relationship.name
        expect(page).to have_selector 'h4', text: second_relationship.name
        expect(page).not_to have_selector 'h4', text: third_relationship.name
        expect(page).to have_selector 'h4', text: forth_relationship.name
      end
    end
  end
end

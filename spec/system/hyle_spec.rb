require 'rails_helper'
include Warden::Test::Helpers

describe 'hylesの統合テスト', type: :system do
  let(:user) { create(:test_user) }
  let!(:category){create(:test_category, user:user)}
  let!(:hyle) { create(:test_hyle, user:user, category:category) }
  let!(:label) {create(:test_label, user:user, hyle:hyle)}
  before do
      login_as user, scope: :user
  end
  context "ヒュレー追加画面から詳細画面" do
    before do
      visit new_users_hyle_path
    end
    it "ヒュレーを誕生日、タグなしで追加する" do
      expect(page).to have_selector 'h2', text: 'ヒュレーの追加'
      #ヒュレー情報の入力に失敗(カテゴリーがない)
      fill_in 'hyle_name', with: "新しいヒュレー"
      click_button 'この内容で追加する'
      sleep 2
      expect(page).to have_selector 'li', text: 'カテゴリーを入力してください' #疑惑
      #ヒュレー情報の入力に失敗(名前がない)
      fill_in 'hyle_name', with: "  "
      select "test_category", from: 'hyle[category_id]'
      click_button 'この内容で追加する'
      expect(page).to have_selector 'li', text: '名前を入力してください'
      #ヒュレー情報の入力に成功
      fill_in 'hyle_name', with: "タグなしヒュレー"
      select "test_category", from: 'hyle[category_id]'
      click_button 'この内容で追加する'
      #ラベル追加ページに遷移
      sleep 3
      expect(page).to have_content 'ヒュレーが追加されました!'
      click_link 'ラベルの追加を終える'
      #詳細ページに遷移し、正しく表示
      expect(page).to have_selector 'h2', text: "タグなしヒュレー"
      expect(page).to have_selector 'td', text: "タグなしヒュレー"
      expect(page).to have_selector 'td', text: "test_category"
      #タグが表示されない
      expect(page).not_to have_selector 'th', text: "タグ"
      #誕生日の表示
      expect(page).to have_selector 'td', text: "--/--/--"
    end
    it 'カテゴリーを追加する' do
      #カテゴリーの追加に失敗
      fill_in 'new-category', with: "  "
      click_button '新しいカテゴリーを追加'
      sleep 2
      expect(page).to have_selector 'li', text: "カテゴリー名を入力してください" #疑惑
      expect(page).to have_select('hyle[category_id]', options: ["カテゴリーを選択してください", "test_category"])
      #カテゴリーの追加に成功
      fill_in 'new-category', with: "新しいカテゴリー"
      click_button '新しいカテゴリーを追加'
      sleep 2
      expect(page).to have_content 'カテゴリーが追加されました' #疑惑
      expect(page).to have_select('hyle[category_id]', options: ["カテゴリーを選択してください", "test_category", "新しいカテゴリー"])
    end
    it 'タグを追加、削除する' do
      #タグの追加に失敗(タグ名が空)
      fill_in 'new-tag', with: " "
      click_button '新しいタグを追加'
      sleep 2
      expect(page).to have_content 'タグ名は空白では追加できません'
      user.reload
      expect(user.tag_list.count).to eq 3
      #タグの追加に失敗(タグ名が空)
      fill_in 'new-tag', with: "a"*21
      click_button '新しいタグを追加'
      expect(page).to have_content 'タグ名は20字以内です'
      user.reload
      expect(user.tag_list.count).to eq 3
      #タグの追加に成功
      fill_in 'new-tag', with: "新しいタグ"
      click_button '新しいタグを追加'
      sleep 2
      expect(page).to have_content 'タグが追加されました!'
      user.reload
      expect(user.tag_list.count).to eq 4
    end
    it '画像を追加する' do
      attach_file 'file', "#{Rails.root}/spec/factories/sample1.jpg", make_visible: true
      fill_in 'hyle_name', with: "画像ありヒュレー"
      select "test_category", from: 'hyle[category_id]'
      click_button 'この内容で追加する'
      #ラベル追加ページに遷移
      sleep 3
      expect(page).to have_content 'ヒュレーが追加されました!'
      click_link 'ラベルの追加を終える'
      #詳細ページに遷移し、正しく表示
      expect(page).to have_selector 'h2', text: "画像ありヒュレー"
      image_id = Hyle.last.hyle_image_id
      #expect(page).to have_selector "img[src$='#{image_id}']"
    end
    it 'ヒュレーを誕生日あり、タグ付けで追加する' do
      #タグ付けでヒュレーを追加する
      fill_in 'hyle_name', with: "タグ付きヒュレー"
      select "2016", from: 'hyle[birthday(1i)]'
      select "12", from: 'hyle[birthday(2i)]'
      select "12", from: 'hyle[birthday(3i)]'
      select "test_category", from: 'hyle[category_id]'
      check "hyle_tag_list_tag2"
      check "hyle_tag_list_tag3"
      click_button 'この内容で追加する'
      #ラベル追加ページに遷移
      sleep 2
      expect(page).to have_content 'ヒュレーが追加されました!'
      click_link 'ラベルの追加を終える'
      sleep 2
      #詳細ページに遷移し、正しく表示
      expect(page).to have_selector 'h2', text: "タグ付きヒュレー"
      expect(page).to have_selector 'td', text: "タグ付きヒュレー"
      expect(page).to have_selector 'td', text: "2016年12月12日"
      expect(page).to have_selector 'td', text: "test_category"
      expect(page).to have_selector 'span', text: "tag2"
      expect(page).to have_selector 'span', text: "tag3"
      expect(page).not_to have_selector 'span', text: "タグ1"
    end
    it 'ラベルを追加する' do
      #ヒュレーを追加
      fill_in 'hyle_name', with: "ラベルありヒュレー"
      select "test_category", from: 'hyle[category_id]'
      click_button 'この内容で追加する'
      sleep 2
      expect(page).to have_content 'ヒュレーが追加されました!'
      #ラベルの追加に失敗する
      fill_in 'new-label-name', with: "a"*21
      fill_in 'new-label-body', with: "  "
      click_button '新しいラベルを追加'
      sleep 2
      expect(page).to have_selector 'li', text: "ラベル名は20文字以内で入力してください"
      expect(page).to have_selector 'li', text: "内容を入力してください"
      #ラベルの追加に成功する
      fill_in 'new-label-name', with: "テストラベル"
      fill_in 'new-label-body', with: "テストラベルの内容"
      click_button '新しいラベルを追加'
      sleep 2
      label = Label.last
      #ラベルを表示する
      expect(page).to have_content "ラベルが追加されました"
      expect(find("#label-name-#{label.id}").value).to eq "テストラベル"
      expect(find("#label-body-#{label.id}").value).to eq "テストラベルの内容"
      #ラベルの編集に失敗する
      fill_in "label-name-#{label.id}", with: "  "
      fill_in "label-body-#{label.id}", with: "テストラベルの内容"
      click_button '変更する'
      expect(page).to have_selector 'li', text: "ラベル名を入力してください"
      #ラベルの編集に成功する
      fill_in "label-name-#{label.id}", with: "編集されたラベル"
      fill_in "label-body-#{label.id}", with: "テストラベルの内容２"
      click_button '変更する'
      expect(page).to have_content "ラベルが変更されました"
      expect(find("#label-name-#{label.id}").value).to eq "編集されたラベル"
      expect(find("#label-body-#{label.id}").value).to eq "テストラベルの内容２"
      #ラベルを削除する
      find("#delete-label-#{label.id}").click
      expect(page).to have_content "ラベルが削除されました"
      expect(page).to have_no_css "#delete-label-#{label.id}"
      #ラベルを追加し、詳細ページへ遷移する
      fill_in 'new-label-name', with: "テストラベル"
      fill_in 'new-label-body', with: "テストラベルの内容"
      click_button '新しいラベルを追加'
      click_link 'ラベルの追加を終える'
      expect(page).to have_selector 'th', text: "テストラベル"
      expect(page).to have_selector 'td', text: "テストラベルの内容"
    end
  end
  context "ヒュレーの編集画面から詳細画面" do
    let!(:other_category){create(:category, user:user)}
    before do
      visit edit_users_hyle_path(hyle)
    end
    it 'ヒュレーの情報を編集する' do
      #ヒュレー情報の編集に失敗
      fill_in 'hyle_name', with: "  "
      click_button '変更を保存する'
      expect(page).to have_selector 'li', text: '名前を入力してください'
      #ヒュレーの情報の編集に成功
      fill_in 'hyle_name', with: "編集したヒュレー"
      select other_category.name, from: 'hyle[category_id]'
      click_button '変更を保存する'
      expect(page).to have_content 'ヒュレーが編集されました!'
      expect(page).to have_select('hyle[category_id]', selected: other_category.name)
      click_link "ヒュレーの編集を終える"
      expect(page).to have_selector 'td', text: "編集したヒュレー"
      #ヒュレーのタグの編集
      visit edit_users_hyle_path(hyle)
      check "hyle_tag_list_tag2"
      check "hyle_tag_list_tag3"
      click_button '変更を保存する'
      expect(page).to have_content 'ヒュレーが編集されました!'
      click_link "ヒュレーの編集を終える"
      expect(page).to have_selector 'td', text: "編集したヒュレー"
      expect(page).to have_selector 'span', text: "tag2"
      expect(page).to have_selector 'span', text: "tag3"
    end
    it 'ラベルの追加、編集、削除ができる' do
      #ラベルの追加に失敗する
      fill_in 'new-label-name', with: "a"*21
      fill_in 'new-label-body', with: "  "
      click_button '新しいラベルを追加'
      sleep 2
      expect(page).to have_selector 'li', text: "ラベル名は20文字以内で入力してください"
      expect(page).to have_selector 'li', text: "内容を入力してください"
      #ラベルの追加に成功する
      fill_in 'new-label-name', with: "テストラベル"
      fill_in 'new-label-body', with: "テストラベルの内容"
      click_button '新しいラベルを追加'
      sleep 2
      label = Label.last.id
      #ラベルを表示する
      expect(page).to have_content "ラベルが追加されました"
      visit current_path #やむなく ReloadなしではjQuery追いつかず
      expect(find("#label-name-#{label}").value).to eq "テストラベル"
      expect(find("#label-body-#{label}").value).to eq "テストラベルの内容"
      #ラベルの編集に失敗する
      fill_in "label-name-#{label}", with: "  "
      fill_in "label-body-#{label}", with: "テストラベルの内容"
      find("#label-edit-button-#{label}").click
      expect(page).to have_selector 'li', text: "ラベル名を入力してください"
      #ラベルの編集に成功する
      fill_in "label-name-#{label}", with: "編集されたラベル"
      fill_in "label-body-#{label}", with: "テストラベルの内容２"
      find("#label-edit-button-#{label}").click
      expect(page).to have_content "ラベルが変更されました"
      expect(find("#label-name-#{label}").value).to eq "編集されたラベル"
      expect(find("#label-body-#{label}").value).to eq "テストラベルの内容２"
      #ラベルを削除する
      find("#delete-label-#{label}").click
      expect(page).to have_content "ラベルが削除されました"
      visit current_path #やむなく
      expect(page).not_to have_css "#delete-label-#{label}"
    end
    it 'ヒュレーを削除する' do
      visit users_hyles_path
      expect(page).to have_selector 'h4', text: 'test_hyle'
      find("#hyle-link-#{hyle.id}").click
      page.accept_confirm("本当にこのヒュレーを削除しますか？") do
        click_link '削除する'
      end
      sleep 2
      expect(page).to have_content "ヒュレーを削除しました"
      expect(page).to have_selector 'h2', text: '全ヒュレー'
      expect(page).not_to have_selector 'h4', text: 'test_hyle'
    end
  end
  context 'ヒュレー一覧画面' do
    let(:other_users_hyle) {create(:test_hyle, user:create(:user), category:category)}
    let(:other_category_hyle) {create(:hyle_without_tag, user:user, category:create(:category))}
    before do
      visit users_hyles_path
    end
    it '全ヒュレー一覧' do
      expect(page).to have_selector 'h2', text: "全ヒュレー"
      #ユーザーのヒュレーが表示される
      expect(page).to have_selector 'h4', text: "test_hyle"
      expect(page).to have_selector 'span', text: "test_category"
      expect(page).to have_selector 'span', text: "tag1"
      #他のユーザーのヒュレーは表示されない
      expect(page).not_to have_selector 'h4', text: "other_users_hyle"
      #ヒュレーをクリックすると詳細ページにリンクする
      find("#hyle-link-#{hyle.id}").click
      expect(page).to have_selector 'h2', text: "test_hyle"
    end
    it 'カテゴリー別ヒュレー一覧' do
      click_link 'test_category', match: :first
      expect(page).to have_selector 'h2', text: "カテゴリー別ヒュレー"
      expect(page).to have_selector 'h4', text: "test_hyle"
      #カテゴリーの違うヒュレーは表示されない
      expect(page).not_to have_selector 'h4', text: "other_category_hyle"
      #他のユーザーのヒュレーは表示されない
      expect(page).not_to have_selector 'h4', text: "other_users_hyle"
    end
    it 'タグ別ヒュレー一覧' do
      click_link 'tag1', match: :first
      sleep 2
      expect(page).to have_selector 'h2', text: "タグ別ヒュレー"
      expect(page).to have_selector 'h4', text: "test_hyle"
      #タグの違うヒュレーは表示されない
      expect(page).not_to have_selector 'h4', text: "other_category_hyle"
      #他のユーザーのヒュレーは表示されない
      expect(page).not_to have_selector 'h4', text: "other_users_hyle"
    end
  end
  context "ヒュレー詳細と思い出" do
    let(:memory){create(:test_memory, user: user)}
    let(:another_memory){create(:memory, user:user)}
    let!(:hyle_memory){create(:hyle_memory, hyle:hyle,memory:memory)}
    let(:another_hyle){create(:hyle, user:user, category:category)}
    it 'ヒュレー詳細画面に、ヒュレーの思い出が表示される' do
      visit users_hyle_path(hyle)
      expect(page).not_to have_content 'ヒュレーが追加されました!'
      expect(page).to have_selector 'h3', text: "#{hyle.name}さんとの思い出"
      expect(page).to have_selector 'h4', text: memory.title
      expect(page).not_to have_selector 'h4', text: another_memory.title
    end
    it 'ヒュレーの思い出がない場合は表示されない' do
      visit users_hyle_path(another_hyle)
      expect(page).not_to have_selector 'h3', text: "#{another_hyle.name}さんとの思い出"
    end
  end
end

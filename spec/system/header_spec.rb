require 'rails_helper'
describe 'ヘッダーのテスト', type: :system do
    before do
        visit root_path
    end

    context "ログインしていない状態" do
        it 'このサイトについてに遷移' do
            click_link 'このサイトについて'
            expect(page).to have_content 'アバウトページ'
        end
    end

end

require 'rails_helper'
include Warden::Test::Helpers

describe 'deviseの統合テスト', type: :system do
    let(:user) { create(:user, :confirmed)}
    before do
        login_as user, scope: :user
    end

    it "メインページ" do
        visit users_path
        expect(page).to have_content 'メインページ'
    end
end

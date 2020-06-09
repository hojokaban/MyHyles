require 'rails_helper'

RSpec.describe "Categories", type: :request do
    before do
        @user = create(:user)
        sign_in @user
    end
    it 'カテゴリーが作成される' do
        expect{
            post users_categories_path, params: { name: "test" }
        }.to change(Category, :count).by(1)
    end
end

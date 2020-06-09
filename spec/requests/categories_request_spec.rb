require 'rails_helper'

RSpec.describe "Categories", type: :request do
    let(:category) { create(:category) }
    before do
        @user = create(:user, :confirmed)
        sign_in @user
    end
    it 'カテゴリーが作成される' do
        expect{
            post users_categories_path, params: { category: {name: "test"}}
        }.to change(Category, :count).by(1)
    end
    it 'カテゴリーが編集される' do
        expect(category.name).to eq "category1"
        patch users_category_path(category), params: {category: {name: "categories1"}}
        expect(category.name).to eq "categories1"
    end
end

require 'rails_helper'

RSpec.describe "Categories", type: :request do
    let(:category) { create(:category) }
    before do
        sign_in category.user
    end
    it 'カテゴリーが作成される' do
        expect{
            post users_categories_path, params: { category: {name: "test"}}
        }.to change(Category, :count).by(1)
    end
    it 'カテゴリーが編集される' do
        expect(category.name).to eq category.name
        patch users_category_path(category), params: {category: {name: "categories"}}
        expect(Category.first.name).to eq "categories"
    end
    it 'カテゴリーが削除される' do
        category
        expect{
            delete users_category_path(category)
        }.to change(Category, :count).by(-1)
    end
end

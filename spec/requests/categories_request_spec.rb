require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:user) { create(:test_user) }
  let!(:category){create(:test_category, user:user)}
  before do
    sign_in user
  end
  it 'カテゴリーが作成される' do
    expect{
      post users_categories_path, xhr: true, params: { category: {name: "test"}}
    }.to change(Category, :count).by(1)
  end
  it 'カテゴリーが編集される' do
    expect(category.name).to eq category.name
    patch users_category_path(category), xhr: true, params: {category: {name: "categories"}}
    expect(category.reload.name).to eq "categories"
  end
  it 'カテゴリーが削除される' do
    expect{
      delete users_category_path(category), xhr: true
    }.to change(Category, :count).by(-1)
  end
end

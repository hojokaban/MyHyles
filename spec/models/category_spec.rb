require 'rails_helper'

RSpec.describe Category, type: :model do
    context "Categoryモデルのバリデーションが正しく稼働" do
        before do
            @category = Category.create!(
                user: create(:user),
                name: "テスト")
        end
        it "正しいカテゴリー" do
            expect(@category).to be_valid
        end
        it "名前が空の場合はNG" do
            @category.name = ""
            expect(@category).not_to be_valid
        end
        it "名前が11字以上の場合はNG" do
            @category.name = "a"*11
            expect(@category).not_to be_valid
        end
    end
end

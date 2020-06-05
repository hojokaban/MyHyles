require 'rails_helper'

RSpec.describe User, type: :model do
    context "Userモデルのバリデーションが正しく稼働" do
        before do
            @user = User.create(
                name: "試験太郎",
                email: "taro@examole.com",
                password: "password")
        end
        it "正しいユーザー" do
            expect(@user).to be_valid
        end
        it "名前が空の場合" do
            @user.name = ""
            expect(@user).not_to be_valid
        end
        it "名前が20字以上の場合" do
            @user.name = "a"*21
            expect(@user).not_to be_valid
        end
        it "メールアドレスが空の場合" do
            @user.email = ""
            expect(@user).not_to be_valid
        end
    end
end

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
        it "名前が空の場合はNG" do
            @user.name = ""
            expect(@user).not_to be_valid
        end
        it "名前が20字以上はNG" do
            @user.name = "a"*21
            expect(@user).not_to be_valid
        end
        it "メールアドレスが空の場合はNG" do
            @user.email = ""
            expect(@user).not_to be_valid
        end
        it "notice_beforeが365より大きい場合はNG" do
            @user.notice_before = 366
            expect(@user).not_to be_valid
        end
        it "termが120より大きい場合はNG" do
            @user.term = 121
            expect(@user).not_to be_valid
        end
    end
end

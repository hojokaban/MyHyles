require 'rails_helper'

RSpec.describe Label, type: :model do
    context "Labelモデルのバリデーションが正しく稼働" do
        before do
            @label = Label.create!(
                                   hyle: create(:test_hyle),
                                   name: "test",
                                   body: "テスト")
        end
        it "正しいラベル" do
            expect(@label).to be_valid
        end
        it "ラベル名が空の場合はNG" do
            @label.name = "  "
            expect(@label).not_to be_valid
        end
        it "ラベル名が21字以上の場合はNG" do
            @label.name = "a"*21
            expect(@label).not_to be_valid
        end
        it "ラベル内容が空の場合はNG" do
            @label.name = "  "
            expect(@label).not_to be_valid
        end
        it "ラベル内容が501字以上の場合はNG" do
            @label.name = "a"*501
            expect(@label).not_to be_valid
        end
    end
end
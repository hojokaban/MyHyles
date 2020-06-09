require 'rails_helper'

RSpec.describe Label, type: :model do
    context "Userモデルのバリデーションが正しく稼働" do
        before do
            @label = Label.create!(name: "test")
        end
        it "正しいラベル" do
            expect(@label).to be_valid
        end
        it "ラベルが空の場合はNG" do
            @label.name = "  "
            expect(@label).not_to be_valid
        end
        it "ラベルが21字以上の場合はNG" do
            @label.name = "a"*21
            expect(@label).not_to be_valid
        end
    end
end

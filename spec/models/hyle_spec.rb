require 'rails_helper'

RSpec.describe Hyle, type: :model do
    context "Hyleモデルのバリデーションが正しく稼働" do
        let(:category) { create(:category) }
        before do
            @hyle = Hyle.create!(
                            name: "試験太郎",
                            user: category.user,
                            category: category)
        end
        it "正しいヒュレー" do
            expect(@hyle).to be_valid
        end
        it "名前が空の場合はNG" do
            @hyle.name = ""
            expect(@hyle).not_to be_valid
        end
        it "名前が20字以上はNG" do
            @hyle.name = "a"*21
            expect(@hyle).not_to be_valid
        end
    end
end

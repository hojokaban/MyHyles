require 'rails_helper'

RSpec.describe Memory, type: :model do
  context "Labelモデルのバリデーションが正しく稼働" do
    let(:user) { create(:test_user) }
    let(:category){create(:test_category, user:user)}
    let(:hyle) { create(:test_hyle, user:user, category:category) }
    before do
      @memory = Memory.create!(
                             title: "test",
                             user: hyle.user,
                             date: "2020-01")
    end
    it "正しいラベル" do
      expect(@memory).to be_valid
    end
    it "タイトルが空の場合はNG" do
      @memory.title = "  "
      expect(@memory).not_to be_valid
    end
    it "タイトルが21字の場合はNG" do
      @memory.title = "a"*21
      expect(@memory).not_to be_valid
    end
    it "タイトルが21字の場合はNG" do
      @memory.description = "a"*501
      expect(@memory).not_to be_valid
    end
  end
end

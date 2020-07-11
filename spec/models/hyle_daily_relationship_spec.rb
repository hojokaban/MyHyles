require 'rails_helper'

RSpec.describe HyleDailyRelationship, type: :model do
  context "HyleDailyRelationshipモデルのバリデーションが正しく稼働" do
    let(:user) { create(:test_user) }
    let(:category){create(:test_category, user:user)}
    let(:hyle){create(:test_hyle, user:user, category:category)}
    let(:daily_relationship){create(:daily_relationship, user:user)}
    before do
      @hyle_daily_relationship = HyleDailyRelationship.create!(
                      hyle: hyle,
                      daily_relationship: daily_relationship)
    end
    it "正しいヒュレー" do
        expect(@hyle_daily_relationship).to be_valid
    end
    it "amountは空白ではいけない" do
      @hyle_daily_relationship.relationship_amount = ""
      expect(@hyle_daily_relationship).not_to be_valid
    end
    it "amountは0以上でないといけない" do
      @hyle_daily_relationship.relationship_amount = -1
      expect(@hyle_daily_relationship).not_to be_valid
    end
    it "amountは100以下でないといけない" do
      @hyle_daily_relationship.relationship_amount = 101
      expect(@hyle_daily_relationship).not_to be_valid
    end
  end
end

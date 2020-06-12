class DailyRelationship < ApplicationRecord
  belongs_to :user
  has_many :hyle_daily_relationships, dependent: :destroy
  has_many :hyles, through: :hyle_daily_relationships
end

class HyleDailyRelationship < ApplicationRecord
  belongs_to :daily_relationship
  belongs_to :hyle

  validates :relationship_amount,  presence: true, numericality:
        {less_than_or_equal_to: 100, greater_than_or_equal_to: 0}
end

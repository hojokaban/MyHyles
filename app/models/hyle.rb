class Hyle < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :labels, dependent: :destroy
  attachment :item_image

  validates :name, presence: true, length: {maximum: 20}
end

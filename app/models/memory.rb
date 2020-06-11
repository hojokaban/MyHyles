class Memory < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {maximum:20}
  validates :description, length: {maximum:500}
  attachment :memory_image
end

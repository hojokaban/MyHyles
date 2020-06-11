class Memory < ApplicationRecord
  belongs_to :user
  has_many :hyle_memories, dependent: :destroy
  has_many :hyles, through: :hyle_memories

  validates :title, presence: true, length: {maximum:20}
  validates :description, length: {maximum:500}
  attachment :memory_image
  attr_accessor :hyle_ids
end

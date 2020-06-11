class Memory < ApplicationRecord
  belongs_to :user
  has_many :hyle_memories, dependent: :destroy
  has_many :hyles, through: :hyle_memories

  validates :title, presence: true, length: {maximum:20}
  validates :description, length: {maximum:500}
  attachment :memory_image
  attr_accessor :hyle_ids

  def set_hyle_memory(hyle_ids)
    hyle_ids.each do |hyle_id|
      HyleMemory.create!(memory:self,hyle_id:hyle_id.to_i) unless hyle_id.blank?
    end
  end
end

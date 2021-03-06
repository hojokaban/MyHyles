class Memory < ApplicationRecord
  belongs_to :user
  has_many :hyle_memories, dependent: :destroy
  has_many :hyles, through: :hyle_memories

  validates :title, presence: true, length: {maximum:20}
  validates :description, length: {maximum:500}
  attachment :memory_image
  attr_accessor :hyle_ids

  def set_hyle_memory(hyle_ids)
    if hyle_ids.nil?
      self.hyle_memories.destroy_all
    else
      related_hyles = self.hyles.pluck(:id)
      hyle_ids.each do |hyle_id|
        if related_hyles.include?(hyle_id)
          related_hyles.delete(hyle_id)
        else
          HyleMemory.create!(memory:self,hyle_id:hyle_id.to_i)
        end
      end
      if related_hyles.present?
        related_hyles.each {|hyle_id| self.hyle_memories.find_by(hyle_id:hyle_id.to_i).destroy}
      end
    end
  end
end

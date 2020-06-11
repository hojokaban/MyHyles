class Hyle < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :labels, dependent: :destroy
  has_many :hyle_memories, dependent: :destroy
  has_many :memories, through: :hyle_memories
  attachment :hyle_image
  acts_as_taggable

  validates :name, presence: true, length: {maximum: 20}

  def set_tag(tags)
    tags.each{|tag| self.tag_list.add(tag.delete_prefix("<call>").delete_suffix("</call>"))}
  end
end

class Hyle < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :labels, dependent: :destroy
  has_many :hyle_memories, dependent: :destroy
  has_many :memories, through: :hyle_memories
  has_many :hyle_daily_relationships, dependent: :destroy
  has_many :daily_relationships, through: :hyle_daily_relationships
  attachment :hyle_image
  acts_as_taggable

  validates :name, presence: true, length: {maximum: 20}

  def set_tag(tags)
    tags.each{|tag| self.tag_list.add(tag)}
    #.delete_prefix("<call>").delete_suffix("</call>")
  end

  def set_birthday_date
    self.birthday_date = birthday.to_s[5..6] + birthday.to_s[8..10]
  end

  def set_relationship(hyle_daily_relationship)
    relationship = self.total_relationship + hyle_daily_relationship.relationship_amount
    self.update(total_relationship: relationship)
  end

  def delete_relationship(hyle_daily_relationship)
    relationship = self.total_relationship - hyle_daily_relationship.relationship_amount
    self.update(total_relationship: relationship)
  end

  def days_before(today)
    birthday = self.birthday
    if (birthday.mon > today.mon) || (birthday.mon == today.mon && birthday.mday >= today.mday)
      result = (birthday.next_year(today.year - birthday.year) - today).numerator
    else
      result = (birthday.next_year(today.year - birthday.year + 1) - today).numerator
    end
    return result
  end

end

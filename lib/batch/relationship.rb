class Batch::Relationship
  def self.relationship
    Hyle.all.each do |hyle|
      hyle.update(birthday_left: hyle.days_before(Date.current)) unless hyle.birthday.nil?
      hyle.set_relationship
    end
    p "ヒュレーの誕生日カウントダウンを更新"
    p "ヒュレーのtotal_relationshipを更新"
    User.all.each do |user|
      user.update(has_done: false)
      user.set_relationship_percentage
    end
    p "関係を翌日分に更新"
    p "ヒュレーの関係性％を更新"
  end
end

class Batch::Relationship
  def self.relationship
    User.all.each do |user|
      user.has_done = false
    end
    p "関係を更新"
    Hyle.all.each do |hyle|
      hyle.days_before(Date.current) unless hyle.birthday.nil?
    end
    p "ヒュレーの誕生日カウントダウンを更新"
  end
end

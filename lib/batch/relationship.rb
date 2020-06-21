class Batch::Relationship
    def self.relationship
      User.all.each do |user|
        user.has_done = false
      end
      Hyle.all.each do |hyle|
        hyle.days_before(Date.current) unless hyle.birthday.nil?
      end
    end
end

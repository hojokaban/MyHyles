class Batch::Relationship
    def self.relationship
      User.all.each do |user|
        user.has_done = false
      end
    end
end

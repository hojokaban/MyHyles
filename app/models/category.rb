class Category < ApplicationRecord
    has_many :hyles
    belongs_to :user

    validates :name, presence: true, length: {maximum: 10}
end

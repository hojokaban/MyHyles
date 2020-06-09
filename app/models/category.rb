class Category < ApplicationRecord
    has_many :hyles, dependent: :destroy
    belongs_to :user

    validates :name, presence: true, length: {maximum: 20}
end

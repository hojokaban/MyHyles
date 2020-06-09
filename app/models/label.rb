class Label < ApplicationRecord
    has_many :hyles

    validates :name, presence: true, length: {maximum: 20}
end

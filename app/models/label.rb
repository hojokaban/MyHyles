class Label < ApplicationRecord
    belongs_to :hyle
    belongs_to :user

    validates :name, presence: true, length: {maximum: 20}
    validates :body, presence: true, length: {maximum: 500}
end

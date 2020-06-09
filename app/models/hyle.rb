class Hyle < ApplicationRecord
  belongs_to :user
  belongs_to :label
  belongs_to :category
end

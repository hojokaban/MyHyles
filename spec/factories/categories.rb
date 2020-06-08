FactoryBot.define do
  factory :category do
    association :user, factory: :user
    sequence(:name) { |n| "category#{n}" }
  end
end

FactoryBot.define do
  factory :category do
    association :user, factory: :test_user
    sequence(:name) { |n| "category#{n}" }
  end
end

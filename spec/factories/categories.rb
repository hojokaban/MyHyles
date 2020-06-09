FactoryBot.define do
  factory :category do
    association :user, factory: :test_user
    sequence(:name) { |n| "category#{n}" }
    factory :test_category do
        name {"test_cate"}
    end
  end
end

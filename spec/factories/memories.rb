FactoryBot.define do
  factory :memory do
    association :user, factory: :test_user
    title { |n| "TEST_TITLE#{n}" }
    date { |n| "2020-06-#{n}" }
    description { "TEST_BODY" }
    factory :test_memory do
      title {"test_title"}
    end
  end
end

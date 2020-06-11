FactoryBot.define do
  factory :memory do
    #association :user, factory: :test_user
    sequence(:title) { |n| "TITLE-#{n}" }
    sequence(:date) { |n| "2020-06-#{n}" }
    description { "TEST_BODY" }
    factory :test_memory do
      title {"test_title"}
    end
    factory :temporary_memory do
      #association :user, factory: :user
    end
  end
end

FactoryBot.define do

    factory :user do
      sequence(:name) { |n| "TEST_NAME#{n}"}
      sequence(:email) { |n| "TEST#{n}@example.com"}
      password {'password'}

      trait :confirmed do
          confirmed_at { Time.now }
      end
      factory :test_user do
          name { "test_user" }
          email { "test@example.com" }
          confirmed_at { Time.now }
          tag_list { ["tag1", "tag2", "tag3"]}
      end
    end

end

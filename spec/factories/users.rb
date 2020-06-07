FactoryBot.define do

    factory :user do
      sequence(:name) { |n| "TEST_NAME#{n}"}
      sequence(:email) { |n| "TEST#{n}@example.com"}
      password {'password'}

      trait :confirmed do
          confirmed_at { Time.now }
      end
    end

end

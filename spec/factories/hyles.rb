FactoryBot.define do

  factory :hyle do
    association :category, factory: :test_category
    user { category.user }
    sequence(:name) {|n| "TEST_HYLE#{n}" }
        factory :test_hyle do
            name {"test_hyle"}
        end
  end

end
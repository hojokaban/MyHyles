FactoryBot.define do

  factory :hyle do
    association :category, factory: :test_category
    user { category.user }
    sequence(:name) {|n| "TEST_HYLE#{n}" }
        factory :test_hyle do
          name {"test_hyle"}
          tag_list {["tag1"]}
        end
        factory :other_users_hyle do
          name {"other_users_hyle"}
          association :user, factory: :user
          tag_list {["tag1"]}
        end
        factory :other_category_hyle do
          name {"other_category_hyle"}
          association :category, factory: :category
        end
  end

end

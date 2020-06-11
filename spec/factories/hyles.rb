FactoryBot.define do

  factory :hyle do
    # association :category, factory: :test_category
    # user { category.user }
    sequence(:name) {|n| "TEST_HYLE#{n}" }
        factory :test_hyle do
          name {"test_hyle"}
          tag_list {["tag1"]}
        end
        factory :hyle_without_tag do
          name {"other_category_hyle"}
          #association :category, factory: :category
        end
  end

end

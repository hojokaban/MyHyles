FactoryBot.define do
  factory :label do
      #association :hyle, factory: :test_hyle
      user { hyle.user }
      name { |n| "label#{n}" }
      body { |n| "label-body#{n}"}
      factory :test_label do
          name {"test_label"}
          body {"test_body"}
      end
  end
end

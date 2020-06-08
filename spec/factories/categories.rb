FactoryBot.define do
  factory :category do
    association :user, factory: :user 
    name { "MyString" }
  end
end

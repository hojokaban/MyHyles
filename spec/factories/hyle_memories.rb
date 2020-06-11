FactoryBot.define do
  factory :hyle_memory do
    association :hyle, factory: :test_hyle
    association :memory, factory: :temporary_memory
    #test_hyleでは、test_userを複製してしまう
  end
end

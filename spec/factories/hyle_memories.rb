FactoryBot.define do
  factory :hyle_memory do
    association :memory, factory: :test_memory
    hyle { memory.user }
  end
end

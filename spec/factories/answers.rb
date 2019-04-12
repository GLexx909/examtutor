FactoryBot.define do
  factory :answer do
    body { "MyString" }
    full_accordance { false }
    question { nil }
    points { 3 }

    trait :invalid do
      body { nil }
    end
  end
end

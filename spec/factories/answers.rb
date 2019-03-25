FactoryBot.define do
  factory :answer do
    body { "MyString" }
    full_accordance { false }
    question { nil }

    trait :invalid do
      body { nil }
    end
  end
end

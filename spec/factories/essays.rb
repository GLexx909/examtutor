FactoryBot.define do
  factory :essay do
    title { "EssayTitle" }

    trait :invalid do
      title { nil }
    end
  end
end

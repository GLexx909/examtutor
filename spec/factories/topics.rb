FactoryBot.define do
  factory :topic do
    title { "TopicTitle" }
    body { "TopicBody" }
    modul { nil }

    trait :invalid do
      title { nil }
    end
  end
end

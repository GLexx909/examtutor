FactoryBot.define do
  factory :test do
    title { "TestTitle" }
    modul { nil }

    trait :invalid do
      title { nil }
    end
  end
end

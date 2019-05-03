FactoryBot.define do
  factory :test do
    title { "TestTitle" }
    timer { 1 }
    modul { nil }

    trait :invalid do
      title { nil }
    end
  end
end

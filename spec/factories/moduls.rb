FactoryBot.define do
  factory :modul do
    title { "ModulTitle" }

    trait :invalid do
      title { nil }
    end
  end
end

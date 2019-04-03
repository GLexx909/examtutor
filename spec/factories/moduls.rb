FactoryBot.define do
  sequence :position do |n|
    n
  end

  factory :modul do
    title { "ModulTitle" }
    position
    trait :invalid do
      title { nil }
    end
  end
end

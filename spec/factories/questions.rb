FactoryBot.define do
  factory :question do
    test { nil }
    title { "QuestionTitle" }

    trait :invalid do
      title { nil }
    end
  end
end

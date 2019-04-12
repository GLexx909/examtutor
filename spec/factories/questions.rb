FactoryBot.define do
  factory :question do
    questionable { nil }
    title { "QuestionTitle" }

    trait :invalid do
      title { nil }
    end
  end
end

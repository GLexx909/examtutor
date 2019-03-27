FactoryBot.define do
  factory :course do
    title { "CourseTitle" }

    trait :invalid do
      title { nil }
    end
  end
end

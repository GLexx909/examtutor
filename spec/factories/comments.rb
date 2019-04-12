FactoryBot.define do
  factory :comment do
    author { nil }
    post { nil }
    body { "CommentBody" }

    trait :invalid do
      body { nil }
    end
  end
end

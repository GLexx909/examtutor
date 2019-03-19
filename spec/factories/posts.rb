FactoryBot.define do
  factory :post do
    title { "Post Title" }
    body { "Post Body" }

    trait :invalid do
      body { nil }
    end
  end

end

FactoryBot.define do
  factory :feedback do
    user { nil }
    body { "MyText" }
    moderation { false }
  end
end

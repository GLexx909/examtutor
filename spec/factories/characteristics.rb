FactoryBot.define do
  factory :characteristic do
    user { nil }
    points { 1 }
    description { "MyText" }
    rank { "MyString" }
  end
end

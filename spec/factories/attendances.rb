FactoryBot.define do
  factory :attendance do
    user { nil }
    description { "MyText" }
    date { DateTime.now }
    color { "MyString" }
  end
end

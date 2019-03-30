FactoryBot.define do
  factory :notification do
    title { "MyString" }
    object { 1 }
    status { false }
  end
end

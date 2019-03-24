FactoryBot.define do
  factory :essay_passage do
    user { nil }
    essay { nil }
    body { "MyString" }
    tutor_note { "MyString" }
    status { "MyString" }
  end
end

FactoryBot.define do
  factory :essay_passage do
    user { nil }
    essay { nil }
    body { "EssayBody" }
    status { false }
  end
end

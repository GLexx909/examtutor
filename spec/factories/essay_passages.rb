FactoryBot.define do
  factory :essay_passage do
    user { nil }
    essay { nil }
    body { "EssayBody" }
    tutor_note { "EssayTutorNote" }
    status { "false" }
  end
end

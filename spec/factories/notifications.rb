FactoryBot.define do
  factory :notification do
    title { "NotificationTitle" }
    abonent { nil }
    author { nil }
    type_of { nil }
    link { nil }

    status { false }
  end
end

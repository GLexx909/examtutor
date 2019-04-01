FactoryBot.define do
  factory :notification do
    title { "NotificationTitle" }
    abonent { nil }
    link { nil }
    status { false }
  end
end

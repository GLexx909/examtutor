FactoryBot.define do
  factory :message do
    author { nil }
    abonent { nil }
    body { "MessageBody" }
    status { false }
  end
end

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    email
    password { '12345678' }
    password_confirmation { '12345678' }
    confirmed_at { '2018-02-06 17:25:45 +0300' }
  end
end

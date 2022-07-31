FactoryBot.define do
  factory :event do
    title { "MyString" }
    description { "MyString" }
    start_date_time { "2022-07-31 19:09:43" }
    end_date_time { "2022-07-31 19:09:43" }
    event { "MyString" }
    user { nil }
  end
end

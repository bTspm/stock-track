FactoryBot.define do
  factory :address do
    line_1 { "231 Abc Avenue" }
    line_2 { "Suite 200" }
    city { "Test City" }
    state { "CA" }
    country { "US" }
    zip_code { "03145-01234" }

    created_at { DateTime.new(2020, 12, 31) }
    updated_at { DateTime.new(2020, 12, 31) }
  end
end

FactoryBot.define do
  factory :watch_list do
    user

    name { "Airlines" }
    symbols { ["DAL", "UAL"] }

    created_at { DateTime.new(2020, 12, 31) }
    updated_at { DateTime.new(2020, 12, 31) }
  end
end

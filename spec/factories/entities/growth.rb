FactoryBot.define do
  factory :entity_growth, class: Entities::Growth do
    transient do
      args do
        {
          day_30: 30,
          day_5: 5,
          max: 100_000,
          month_1: 100,
          month_3: 300,
          month_6: 600,
          year_1: 1_000,
          year_2: 2_000,
          year_5: 5_000,
          ytd: 10_000
        }
      end
    end

    initialize_with { new(args) }
  end
end

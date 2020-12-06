FactoryBot.define do
  factory :entity_quote, class: Entities::Quote do
    transient do
      args do
        {
          change: 100,
          change_percent: 10,
          close: 250,
          extended_change: 200,
          extended_change_percent: 25,
          extended_price: 260,
          extended_time: DateTime.new(2020, 0o1, 0o1, 0o0, 0o0, 0o0),
          high: 500,
          is_us_market_open: true,
          latest_price: 600,
          latest_source: "IEX",
          latest_update:  DateTime.new(2019, 0o1, 0o1, 0o0, 0o0, 0o0),
          latest_volume: 1_000,
          low: 2_000,
          open: 5_000,
          previous_close: 4_000,
          previous_volume: 8_000,
          volume: 9_000
        }
      end
    end

    initialize_with { new(args) }
  end
end

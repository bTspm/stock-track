FactoryBot.define do
  factory :entity_quote, class: Entities::Quote do
    transient do
      args do
        {
          change: 100,
          change_percent: 10,
          high: 300_000,
          price: 100_000,
          source: "IEX",
          updated_at: DateTime.new(2019, 0o1, 0o1, 0o0, 0o0, 0o0),
          low: 600_000,
          open: 700_000,
          previous_close: 800_000,
          volume: 1_000_000
        }
      end
    end

    initialize_with { new(args) }
  end
end

FactoryBot.define do
  factory :entity_exchange, class: Entities::Exchange do
    transient do
      args do
        {
          country: build(:entity_country),
          code: "NYSE",
          id: 500,
          name: "New York Stock Exchange"
        }
      end
    end

    trait :non_usa do
      transient do
        args do
          {
            country: build(:entity_country, :ind),
          }
        end
      end
    end

    trait :nasdaq do
      transient do
        args do
          {
            id: Entities::Exchange::NASDAQ_CAPITAL_MARKET_ID,
          }
        end
      end
    end

    trait :nyse do
      transient do
        args do
          {
            id: Entities::Exchange::NEW_YORK_STOCK_EXCHANGE_ID,
          }
        end
      end
    end

    initialize_with { new(args) }
  end
end

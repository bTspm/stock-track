FactoryBot.define do
  factory :entity_company, class: Entities::Company do
    args do
      {
        address: build(:entity_address),
        exchange: build(:entity_exchange),
        issuer_type: build(:entity_issuer_type),
        description: "Test",
        employees: 137_000,
        id: 200,
        industry: "Telecommunications Equipment",
        name: "Apple Inc.",
        phone: "1.408.996.1010",
        sector: "Electronic Technology",
        security_name: "Apple Inc.",
        sic_code: 3663,
        symbol: "AAPL",
        website: "http://www.apple.com"
      }
    end

    trait :without_address do
      address { nil }
    end

    trait :etf do
      issuer_type { build(:entity_issuer_type, :etf) }
    end

    trait :nasdaq do
      exchange { build(:entity_exchange, :nasdaq) }
    end

    trait :nyse do
      exchange { build(:entity_exchange, :nyse) }
    end

    initialize_with { new(args) }
  end
end

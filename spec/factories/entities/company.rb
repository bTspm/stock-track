FactoryBot.define do
  factory :entity_company, class: Entities::Company do
    transient do
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
    end

    trait :company_without_address do
      transient do
        args do
          {
            exchange: build(:entity_exchange),
            issuer_type: build(:entity_issuer_type),
            address: nil,
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
      end
    end

    initialize_with { new(args) }

    factory :company_without_address, traits: [:without_address]
  end
end

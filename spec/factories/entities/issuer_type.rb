FactoryBot.define do
  factory :entity_issuer_type, class: Entities::IssuerType do
    transient do
      args do
        {
          code: "CS",
          id: 123,
          name: "Common Stock"
        }
      end
    end

    trait :etf do
      transient do
        args do
          {
            code: Entities::IssuerType::ETF_CODE,
            id: 123,
            name: "ETF"
          }
        end
      end
    end

    initialize_with { new(args) }
  end
end

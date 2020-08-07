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

    initialize_with { new(args) }
  end
end
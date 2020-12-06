FactoryBot.define do
  factory :entity_stock, class: Entities::Stock do
    transient do
      args do
        {
          company: build(:entity_company),
          growth: build(:entity_growth),
          quote: build(:entity_quote),
          stats: build(:entity_stats),
        }
      end
    end

    initialize_with { new(args) }
  end
end

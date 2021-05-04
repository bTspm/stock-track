FactoryBot.define do
  factory :entity_external_analyses_analysis, class: Entities::ExternalAnalyses::Analysis do
    args do
      {
        analysts_count: 100,
        original_rating: "Strong Buy",
        price_target: OpenStruct.new({ low: 100, average: 150, high: 200 }),
        rating_rank: 3,
        source: Entities::ExternalAnalyses::Analysis::WE_BULL,
        url: "https://example.com"
      }
    end

    trait :no_rating_rank do
      rating_rank { nil }
    end

    trait :no_price_target do
      price_target { nil }
    end

    trait :no_original_rating do
      original_rating { nil }
    end

    initialize_with { new(args) }
  end
end

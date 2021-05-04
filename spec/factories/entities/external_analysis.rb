FactoryBot.define do
  factory :entity_external_analysis, class: Entities::ExternalAnalysis do
    args do
      {
        analyses: Array.wrap(build :entity_external_analyses_analysis),
        refreshed_at: DateTime.new(2021, 01, 01)
      }
    end

    initialize_with { new(args) }
  end
end

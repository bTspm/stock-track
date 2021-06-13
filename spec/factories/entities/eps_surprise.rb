FactoryBot.define do
  factory :entity_eps_surprise, class: Entities::EpsSurprise do
    args do
      {
        actual: 1.23,
        date: Date.new(2020, 01, 01),
        estimate: 3.45,
      }
    end

    initialize_with { new(args) }
  end
end

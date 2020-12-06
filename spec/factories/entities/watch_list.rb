FactoryBot.define do
  factory :entity_watch_list, class: Entities::WatchList do
    transient do
      args do
        {
          id: 200,
          name: "Airlines",
          symbols: ["AAPL", "AAL"],
        }
      end
    end

    initialize_with { new(args) }
  end
end

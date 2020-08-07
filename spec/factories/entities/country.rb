FactoryBot.define do
  factory :entity_country, class: Entities::Country do
    transient do
      args { { alpha2: "US", code: "USA", name: "United States of America" } }
    end

    initialize_with { new(args) }
  end
end

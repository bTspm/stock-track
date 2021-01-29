FactoryBot.define do
  factory :entity_country, class: Entities::Country do
    transient do
      args do
        {
          alpha2: "US",
          code: "USA",
          name: "United States of America"
        }
      end
    end

    trait :ind do
      transient do
        args do
          {
            alpha2: "IN",
            code: "IND",
            name: "India"
          }
        end
      end
    end

    initialize_with { new(args) }
  end
end

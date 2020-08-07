FactoryBot.define do
  factory :entity_address, class: Entities::Address do
    transient do
      args do
        {
          country: build(:entity_country),
          state: build(:entity_state),
          city: "Test City",
          id: 200,
          line_1: "231 Abc Avenue",
          line_2: "Suite 200",
          zip_code: "03145-01234"
        }
      end
    end

    initialize_with { new(args) }
  end
end

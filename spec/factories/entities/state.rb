FactoryBot.define do
  factory :entity_state, class: Entities::State do
    transient do
      args { { code: "NH", name: "New Hampshire" } }
    end

    initialize_with { new(args) }
  end
end

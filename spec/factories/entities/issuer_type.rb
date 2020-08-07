FactoryBot.define do
  factory :entity_issuer_type, class: Entities::IssuerType do
    transient do
      args { { code: "CS", id: 123, name: "Common Stock" } }
    end

    initialize_with { new(args) }
  end
end

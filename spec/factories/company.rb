FactoryBot.define do
  factory :company do
    address
    exchange
    issuer_type

    description { "Test" }
    employees { 137_000 }
    industry { "Telecommunications Equipment" }
    name { "Apple} Inc." }
    phone { "1.408.996.1010" }
    sector { "Electronic Technology" }
    security_name { "Apple Inc." }
    sic_code { 3663 }
    symbol { "AAPL" }
    website { "http://www.apple.com" }

    created_at { DateTime.new(2020, 12, 31) }
    updated_at { DateTime.new(2020, 12, 31) }
  end
end

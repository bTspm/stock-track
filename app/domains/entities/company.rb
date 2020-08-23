module Entities
  class Company < BaseEntity
    include HasDbEntity
    include HasElasticsearch

    ATTRIBUTES = %i[address
                    company_executives
                    description
                    employees
                    exchange
                    id
                    industry
                    issuer_type
                    name
                    phone
                    sector
                    security_name
                    sic_code
                    symbol
                    website].freeze

    attr_accessor *ATTRIBUTES
    delegate :line_1, to: :address, allow_nil: true
    delegate :code, :id, :name, to: :exchange, allow_nil: true, prefix: true
    delegate :etf?, to: :issuer_type, allow_nil: true
    delegate :code, :id, :name, to: :issuer_type, allow_nil: true, prefix: true

    def self.from_iex_response(response)
      args = {
        address: Entities::Address.from_iex_response(response),
        description: response[:description],
        employees: response[:employees],
        exchange: Entities::Exchange.from_iex_company_response(response),
        industry: response[:industry],
        issuer_type: Entities::IssuerType.from_iex_company_response(response),
        name: response[:companyName],
        phone: response[:phone],
        sector: response[:sector],
        security_name: response[:securityName],
        sic_code: response[:primarySicCode],
        symbol: response[:symbol],
        website: response[:website]
      }

      new(args)
    end
  end
end

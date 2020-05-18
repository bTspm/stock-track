module Entities
  class Company
    include BaseEntity

    ATTRIBUTES = %i[address
                    description
                    employees
                    executives
                    exchange
                    id
                    industry
                    issuer_type
                    name
                    sector
                    security_name
                    sic_code
                    symbol
                    website].freeze

    attr_accessor *ATTRIBUTES

    delegate :etf?, to: :issuer_type, allow_nil: true

    def self.from_db_entity(entity)
      return if entity.blank?

      executives = entity.company_executives.map { |executive| Entities::CompanyExecutive.from_db_entity(executive) }
      args = {
       address: Entities::Address.from_db_entity(entity.address),
       description: entity.description,
       employees: entity.employees,
       exchange: Entities::Exchange.from_db_entity(entity.exchange),
       executives: executives,
       id: entity.id,
       industry: entity.industry,
       issuer_type: Entities::IssuerType.from_db_entity(entity.issuer_type),
       name: entity.name,
       sector: entity.sector,
       security_name: entity.security_name,
       sic_code: entity.sic_code,
       symbol: entity.symbol,
       website: entity.website
      }

      new(args)
    end

    def self.from_iex_response(response)
      args = {
       address: Entities::Address.from_iex_response(response),
       description: response[:description],
       employees: response[:employees],
       exchange: Entities::Exchange.from_iex_company_response(response),
       industry: response[:industry],
       issuer_type: Entities::IssuerType.from_iex_company_response(response),
       name: response[:companyName],
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

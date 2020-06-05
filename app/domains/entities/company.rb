module Entities
  class Company < DbEntity
    BASE_ATTRIBUTES = %i[description
                         employees
                         id
                         industry
                         name
                         phone
                         sector
                         security_name
                         sic_code
                         symbol
                         website].freeze
    ATTRIBUTES = %i[address
                    executives
                    exchange
                    issuer_type].freeze + BASE_ATTRIBUTES

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

    protected

    def self._db_entity_args(entity)
      super.merge(
       address: Entities::Address.from_db_entity(entity.address),
       exchange: Entities::Exchange.from_db_entity(entity.exchange),
       executives: entity.company_executives.map { |executive| Entities::CompanyExecutive.from_db_entity(executive) },
       issuer_type: Entities::IssuerType.from_db_entity(entity.issuer_type),
      ).with_indifferent_access
    end
  end
end

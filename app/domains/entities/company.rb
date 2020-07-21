module Entities
  class Company < BaseEntity
    include HasDbEntity
    include HasElasticsearch

    BASE_ATTRIBUTES = %i[description
                         employees
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
                    id
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

    def self._after_extract_from_es(args)
      super.merge(executives: args[:executives]&.map { |executive| Entities::CompanyExecutive.new(executive) })
    end

    def self._after_extract_args_from_db_entity(entity)
      super.merge(
        executives: entity.company_executives.map { |executive| Entities::CompanyExecutive.from_db_entity(executive) }
      ).with_indifferent_access
    end

    def self._es_key_prefix
      ""
    end
  end
end

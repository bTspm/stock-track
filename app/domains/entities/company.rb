module Entities
  class Company
    attr_accessor :address,
                  :description,
                  :employees,
                  :executives,
                  :exchange,
                  :id,
                  :industry,
                  :issuer_type,
                  :logo_url,
                  :name,
                  :sector,
                  :security_name,
                  :sic_code,
                  :symbol,
                  :website

    def initialize(args = {})
      @address = args[:address]
      @description = args[:description]
      @employees = args[:employees]
      @executives = args[:executives]
      @exchange = args[:exchange]
      @id = args[:id]
      @industry = args[:industry]
      @issuer_type = args[:issuer_type]
      @name = args[:name]
      @sector = args[:sector]
      @security_name = args[:security_name]
      @sic_code = args[:sic_code]
      @symbol = args[:symbol]
      @website = args[:website]
      @logo_url = args[:logo_url] || _logo_url
    end

    def self.from_db_entity(entity)
      return if entity.blank?

      executives = entity.company_executives.map { |executive| Entities::CompanyExecutive.from_db_entity(executive) }
      args = {
        address: Entities::Address.from_db_entity(entity.address),
        description: entity.description,
        employees: entity.employees,
        exchange: Entities::Exchange.from_db_entity(entity.exchange),
        executives: executives,
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
        ceo: response[:CEO],
        description: response[:description],
        employees: response[:employees],
        exchange: Entities::Exchange.from_iex_company_response(response),
        industry: response[:industry],
        issuer_type: Entities::IssuerType.from_iex_company_response(response),
        logo_url: "#{ENV['IEX_SYMBOl_LOGO_PREFIX']}#{response[:symbol]}.png",
        name: response[:companyName],
        sector: response[:sector],
        security_name: response[:securityName],
        sic_code: response[:primarySicCode],
        symbol: response[:symbol],
        website: response[:website]
      }

      new(args)
    end

    def etf?
      issuer_type.code == "ET"
    end

    private

    def _logo_url
      "#{ENV['IEX_SYMBOl_LOGO_PREFIX']}#{@symbol}.png"
    end
  end
end

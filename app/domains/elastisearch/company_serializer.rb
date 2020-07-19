module Elasticsearch
  class CompanySerializer
    ATTRIBUTES = %i[address_city
                    address_country_alpha2
                    address_country_code
                    address_country_name
                    address_line1
                    address_line2
                    address_state_code
                    address_state_name
                    description
                    exchange_code
                    exchange_country_alpha2
                    exchange_country_code
                    exchange_country_name
                    exchange_name
                    executives
                    id
                    industry
                    issuer_type_code
                    issuer_type_name
                    name
                    sector
                    security_name
                    sic_code
                    symbol].freeze

    attr_reader *ATTRIBUTES

    def initialize(args = {})
      args = args.with_indifferent_access
      ATTRIBUTES.each do |attribute|
        instance_variable_set(:"@#{attribute}", args.dig(attribute))
      end
    end

    class << self
      def from_entity(company)
        args = _company(company).merge(
          _address(company.address),
          _exchange(company.exchange),
          _issuer_type(company.issuer_type)
        )

        new(args)
      end

      private

      def _address(address)
        return {} if address.blank?

        {
          address_line1: address.line_1,
          address_line2: address.line_2,
          address_city: address.city,
          address_state_code: address.state_code,
          address_state_name: address.state_name
        }.merge(_country(country: address.country, entity_name: "address"))
      end

      def _company(company)
        {
          id: company.id,
          description: company.description,
          executives: company.executives,
          industry: company.industry,
          name: company.name,
          sector: company.sector,
          security_name: company.security_name,
          sic_code: company.sic_code,
          symbol: company.symbol
        }
      end

      def _country(country:, entity_name:)
        {
          "#{entity_name}_country_alpha2": country.alpha2,
          "#{entity_name}_country_code": country.code,
          "#{entity_name}_country_name": country.name
        }
      end

      def _exchange(exchange)
        {
          exchange_code: exchange.code,
          exchange_name: exchange.name
        }.merge(_country(country: exchange.country, entity_name: "exchange"))
      end

      def _issuer_type(issuer_type)
        {
          issuer_type_code: issuer_type.code,
          issuer_type_name: issuer_type.name
        }
      end
    end
  end
end

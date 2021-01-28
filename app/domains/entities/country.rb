module Entities
  class Country < BaseEntity
    include HasElasticsearch

    ATTRIBUTES = %i[alpha2 code name].freeze
    CHINA_ISO2_CODE = "CN"
    USA_CODE = "usa".freeze

    attr_accessor *ATTRIBUTES

    def usa?
      code&.downcase == USA_CODE
    end

    class << self
      def from_code(code)
        return if code.blank?

        code = CHINA_ISO2_CODE if code.include? "China"
        country = ISO3166::Country[code] ||ISO3166::Country.find_country_by_name(code)
        _from_hex_country(country)
      end

      private

      def _from_hex_country(country)
        return if country.blank?

        args = {
          alpha2: country.alpha2,
          code: country.alpha3,
          name: country.name
        }

        new(args)
      end
    end
  end
end

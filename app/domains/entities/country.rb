module Entities
  class Country < BaseEntity
    include HasElasticsearch

    ATTRIBUTES = %i[alpha2 code name].freeze

    attr_accessor *ATTRIBUTES

    class << self
      def from_code(code)
        _from_hex_country(ISO3166::Country[code])
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

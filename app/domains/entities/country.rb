module Entities
  class Country < BaseEntity
    include HasElasticsearch
    ATTRIBUTES = %i[alpha2 code name].freeze

    attr_accessor *ATTRIBUTES

    def self.from_code(code)
      from_hex_country(ISO3166::Country[code])
    end

    def self.from_hex_country(country)
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

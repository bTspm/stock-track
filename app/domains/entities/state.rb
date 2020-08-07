module Entities
  class State < BaseEntity
    include HasElasticsearch

    ATTRIBUTES = %i[code name].freeze

    attr_accessor *ATTRIBUTES

    def self.from_code(code:, country_code:)
      return if code.blank? || country_code.blank?

      country = ISO3166::Country[country_code]
      return if country.blank?

      state = country.states[code]
      new({ code: code, name: (state&.name || code) })
    end
  end
end

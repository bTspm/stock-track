module Entities
  class Address < BaseEntity
    include HasDbEntity
    include HasElasticsearch

    ATTRIBUTES = %i[city
                    country
                    id
                    line_1
                    line_2
                    state
                    zip_code].freeze

    attr_accessor *ATTRIBUTES
    delegate :alpha2, :name, :code, to: :country, prefix: true
    delegate :name, :code, to: :state, allow_nil: true, prefix: true

    def self.from_iex_response(response = {})
      args = {
        city: response[:city],
        country: Entities::Country.from_code(response[:country]),
        line_1: response[:address],
        line_2: response[:address2],
        state: Entities::State.from_code(code: response[:state], country_code: response[:country]),
        zip_code: response[:zip]
      }

      new(args)
    end
  end
end

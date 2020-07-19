module Entities
  class Address < DbEntity
    include HasElasticsearch

    BASE_ATTRIBUTES = %i[city
                         country
                         line_1
                         line_2
                         state
                         zip_code].freeze
    ATTRIBUTES = %i[id] + BASE_ATTRIBUTES

    attr_reader *ATTRIBUTES
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

    protected

    def self._db_entity_args(entity)
      super.merge(
        country: Entities::Country.from_code(entity.country),
        state: Entities::State.from_code(code: entity.state, country_code: entity.country),
      ).with_indifferent_access
    end
  end
end

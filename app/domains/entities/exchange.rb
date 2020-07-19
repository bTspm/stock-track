module Entities
  class Exchange < DbEntity
    include HasElasticsearch

    BASE_ATTRIBUTES = %i[code country name].freeze
    ATTRIBUTES = %i[id] + BASE_ATTRIBUTES

    attr_reader *ATTRIBUTES
    delegate :alpha2, :code, :name, to: :country, prefix: true

    def self.from_iex_company_response(response)
      new({ name: response[:exchange] })
    end

    def self.from_iex_response(response)
      args = {
        code: response[:exchange],
        country: response[:region],
        name: response[:description]
      }

      new(args)
    end

    protected

    def self._db_entity_args(entity)
      super.merge(country: Entities::Country.from_code(entity.country)).with_indifferent_access
    end
  end
end

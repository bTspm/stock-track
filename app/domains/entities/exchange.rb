module Entities
  class Exchange < BaseEntity
    include HasDbEntity
    include HasElasticsearch

    ATTRIBUTES = %i[code country id name].freeze

    attr_accessor *ATTRIBUTES
    delegate :alpha2, :code, :name, to: :country, prefix: true

    def self.from_iex_company_response(response)
      new({ name: response[:exchange] })
    end

    def self.from_iex_response(response)
      args = {
        code: response[:exchange],
        country: Entities::Country.from_code(response[:region]),
        name: response[:description]
      }

      new(args)
    end
  end
end

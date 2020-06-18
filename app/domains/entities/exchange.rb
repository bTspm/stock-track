module Entities
  class Exchange < DbEntity
    BASE_ATTRIBUTES = %i[code country name].freeze
    ATTRIBUTES = %i[id] + BASE_ATTRIBUTES

    attr_reader *ATTRIBUTES

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
  end
end

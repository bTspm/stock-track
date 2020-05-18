module Entities
  class Exchange
    include BaseEntity
    include DbEntity

    ATTRIBUTES = %i[code
                    country
                    id
                    name].freeze

    attr_reader *ATTRIBUTES

    def self.from_iex_company_response(response)
      new({name: response[:exchange]})
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

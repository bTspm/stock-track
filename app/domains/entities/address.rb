module Entities
  class Address < BaseEntity
    ATTRIBUTES = %i[city
                    country
                    id
                    line_1
                    line_2
                    state
                    zip_code].freeze

    attr_reader *ATTRIBUTES

    def self.from_iex_response(response = {})
      args = {
        city: response[:city],
        country: response[:country],
        line_1: response[:address],
        line_2: response[:address2],
        state: response[:state],
        zip_code: response[:zip]
      }

      new(args)
    end
  end
end

module IexDeserializers
  class Address
    def from_response(response = {})
      args = {
          city: response[:city],
          country: response[:country],
          line_1: response[:address],
          line_2: response[:address2],
          state: response[:state],
          zip_code: response[:zip]
      }

      Entities::Address.new(args)
    end
  end
end


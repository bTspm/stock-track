module IexDeserializers
  class Exchange
    def from_company_response(response = {})
      args = {name: response[:exchange]}

      Entities::Exchange.new(args)
    end

    def from_exchange_response(response = {})
      args = {
          code: response[:exchange],
          country: response[:region],
          name: response[:description]
      }

      Entities::Exchange.new(args)
    end
  end
end

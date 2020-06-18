class CompanyExecutiveStore
  include Allocator::ApiClients
  include Cacheable

  def by_symbol_from_finn_hub(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = finn_hub_client.company_executives(symbol)
      response.body[:executive].map do |executive_response|
        Entities::CompanyExecutive.from_finn_hub_response(executive_response)
      end
    end
  end
end

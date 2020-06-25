class CompanyExecutiveStore
  include ApiClients
  include Cacheable

  def by_symbol_from_finn_hub(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = finn_hub_client.company_executives(symbol)
      response.body[:executive].map { |datum| Entities::CompanyExecutive.from_finn_hub_response(datum) }
    end
  rescue ApiExceptions::PremiumDataError
    []
  end
end

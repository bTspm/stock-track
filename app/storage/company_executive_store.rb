class CompanyExecutiveStore
  include Allocator::ApiClients

  def by_symbol_from_finn_hub(symbol)
    response = finn_hub_client.company_executives(symbol)
    response.body[:executive].map do |executive_response|
      Entities::CompanyExecutive.from_finn_hub_response(executive_response)
    end
  end

  def by_symbol(symbol)
    executives = CompanyExecutive.where(company_id: Company.where(symbol: symbol).first.id)
    executives.map { |executive| Entities::CompanyExecutive.from_db_entity(executive) }
  end
end

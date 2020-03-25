module DbDeserializers
  class Company
    def from_db_entity(entity)
      return Entities::Company.null_object if entity.blank?

      args = {
          address: DbDeserializers::Address.new.from_db_entity(entity.address),
          description: entity.description,
          employees: entity.employees,
          exchange: DbDeserializers::Exchange.new.from_db_entity(entity.exchange),
          executives: _company_executives(entity.company_executives),
          industry: entity.industry,
          issuer_type: DbDeserializers::IssuerType.new.from_db_entity(entity.issuer_type),
          name: entity.name,
          sector: entity.sector,
          security_name: entity.security_name,
          sic_code: entity.sic_code,
          symbol: entity.symbol,
          website: entity.website
      }

      Entities::Company.new(args)
    end

    private

    def _company_executives(executives)
      return [] if executives.blank?

      executives.map { |executive| Entities::CompanyExecutive.from_db_entity(executive) }
    end
  end
end

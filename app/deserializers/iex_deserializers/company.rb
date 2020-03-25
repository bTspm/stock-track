module IexDeserializers
  class Company
    def from_response(response = {})
      args = {
          address: IexDeserializers::Address.new.from_response(response),
          ceo: response[:CEO],
          description: response[:description],
          employees: response[:employees],
          exchange: IexDeserializers::Exchange.new.from_company_response(response),
          industry: response[:industry],
          issuer_type: IexDeserializers::IssuerType.new.from_company_response(response),
          logo_url: "#{ENV['IEX_SYMBOl_LOGO_PREFIX']}#{response[:symbol]}.png",
          name: response[:companyName],
          sector: response[:sector],
          security_name: response[:securityName],
          sic_code: response[:primarySicCode],
          symbol: response[:symbol],
          website: response[:website]
      }

      Entities::Company.new(args)
    end
  end
end

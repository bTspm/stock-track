module IexDeserializers
  class IssuerType
    def from_company_response(response = {})
      args = {code: response[:issueType]}

      Entities::IssuerType.new(args)
    end
  end
end


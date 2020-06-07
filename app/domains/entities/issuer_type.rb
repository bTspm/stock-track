module Entities
  class IssuerType < DbEntity
    ETF_CODE = "ET".freeze
    ATTRIBUTES = %i[code id name].freeze

    attr_reader *ATTRIBUTES

    def self.from_iex_company_response(response = {})
      new({ code: response[:issueType] })
    end

    def etf?
      return false if code.blank?

      code.upcase == ETF_CODE
    end
  end
end

module Entities
  class IssuerType < BaseEntity
    include HasDbEntity
    include HasElasticsearch

    ETF_CODE = "ET".freeze
    ATTRIBUTES = %i[code id name].freeze

    attr_accessor *ATTRIBUTES

    def self.from_iex_company_response(response = {})
      new({ code: response[:issueType] })
    end

    def etf?
      return false if code.blank?

      code.upcase == ETF_CODE
    end
  end
end

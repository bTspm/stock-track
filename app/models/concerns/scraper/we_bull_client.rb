module Scraper
  class WeBullClient < ::BaseClient
    NASADAQ = "nasdaq".freeze
    NYSE = "nyse".freeze

    def rating_by_company(company)
      response = get("https://www.webull.com/quote/#{_url_key(company)}").body
      Nokogiri::HTML(response).css("div.jss19ghvuu").map(&:text).join
    end

    private

    def _url_key(company)
      "#{_exchange_key(company)}-#{company.symbol.gsub(".", "-").downcase}"
    end

    def _exchange_key(company)
      return NASADAQ if company.nasdaq?
      return NYSE if company.nyse?

      raise StandardError, "Exchange Not Identified: #{company.exchange_id}. Symbol: #{company.symbol}."
    end
  end
end

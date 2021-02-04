module Scraper
  class WeBullClient < ::BaseClient
    def rating_by_company(company)
      response = get("https://www.webull.com/quote/#{_url_key(company)}").body
      Nokogiri::HTML(response).css("div.jss19ghvuu").map(&:text).join
    end

    private

    def _url_key(company)
      exchange_key = _exchange_key(company.exchange_id)
      "#{exchange_key}-#{company.symbol.gsub(".", "-").downcase}"
    end

    def _exchange_key(id)
      case id
      when *Exchange::NASDAQ_IDS
        "nasdaq"
      when Exchange::NEW_YORK_STOCK_EXCHANGE_ID
        "nyse"
      else
        ""
      end
    end
  end
end

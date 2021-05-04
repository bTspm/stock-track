module Scraper
  class WeBullClient < ::BaseClient
    NASADAQ = "nasdaq".freeze
    NYSE = "nyse".freeze

    def analysis_by_company(company)
      url = "https://www.webull.com/quote/#{_url_key(company)}"
      response = Nokogiri::HTML(get(url).body)
      args = {
        analysts_count: response.css("p.jss1ape2j4").map(&:text).join.to_integer,
        original_rating: response.css("div.jss19ghvuu").map(&:text).join,
        price_target: _price_target(response),
        source: Entities::ExternalAnalyses::Analysis::WE_BULL,
        url: url
      }

      Entities::ExternalAnalyses::Analysis.new(args)
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

    def _price_target(response)
      prince_target_string = response.css("div.jss3lf6pl")
      return if prince_target_string.blank?

      average, high, low = prince_target_string.map(&:text).join.to_floats
      {
        average: average,
        high: high,
        low: low
      }
    end
  end
end

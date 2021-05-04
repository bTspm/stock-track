module Scraper
  class ZacksClient < ::BaseClient
    def rating_by_symbol(symbol)
      url = "https://www.zacks.com/stock/quote/#{symbol}/"
      response = Nokogiri::HTML(get(url).body).css("p.rank_view").map(&:text)

      args = {
        custom: _custom(response),
        original_rating: _rating(response),
        source: Entities::ExternalAnalyses::Analysis::ZACKS,
        url: url
      }

      Entities::ExternalAnalyses::Analysis.new(args)
    end

    private

    def _custom(response)
      args = response
               .map(&:strip)[1]
               .split(" | ")
               .each_with_object({}) { |c, hash| hash[c.from(2).downcase] = c.first }
      return nil if args.values.all? { |value| value.blank? || value == "N" }

      args
    end

    def _rating(response)
      response
        .first
        .gsub!(/[^A-Za-z ]/, '')
        .remove("of")
        .strip!
    end
  end
end

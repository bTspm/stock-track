  class Stock

    attr_accessor :company,
                  :news,
                  :quote,
                  :stats

    def initialize(response = {})
      @response = response
      # @company = ::IexDeserializers::Company.new.from_response(response[:company])
      @news = @response[:news].map { |news_article| NewsArticle.new(news_article) }
      @quote = Quote.new(response[:quote])
      @stats = Stats.new(response[:stats])
    end
  end

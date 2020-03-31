  class Stock

    attr_accessor :company,
                  :news,
                  :quote,
                  :stats

    def initialize(response = {})
      @response = response
      @news = @response[:news].map { |news_article| NewsArticle.new(news_article) }
      @quote = Quote.new(response[:quote])
      @stats = Stats.new(response[:stats])
    end
  end

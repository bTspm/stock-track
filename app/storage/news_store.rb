class NewsStore
  include Allocator::ApiClients
  include Cacheable

  DEFAULT_NEWS_ARTICLES_COUNT = 4

  def by_symbol_from_iex(symbol:, count: DEFAULT_NEWS_ARTICLES_COUNT)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}-#{count}") do
      response = iex_client.news_by_symbol(symbol: symbol, count: count)
      response.body.map { |news_article| Entities::NewsArticle.from_iex_response(news_article) }
    end
  end

  protected

  def _expiry
    1.hour
  end
end

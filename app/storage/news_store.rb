class NewsStore
  include Allocator::ApiClients

  def by_symbol_from_iex(symbol:, count: 4)
    response = iex_client.news_by_symbol(symbol: symbol, count: count)
    response.body.map { |news_article| Entities::NewsArticle.from_iex_response(news_article) }
  end
end

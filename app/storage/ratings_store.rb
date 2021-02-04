class RatingsStore
  SOURCE_AND_CLIENTS_BY_COMPANY = {
    Entities::Rating::WE_BULL => :we_bull_client,
  }
  SOURCES_AND_CLIENTS_BY_SYMBOL = {
    Entities::Rating::BAR_CHART => :bar_chart_client,
    # Entities::Rating::NASDAQ_COM => :nasdaq_client,
    Entities::Rating::TIP_RANKS => :tip_ranks_client,
    Entities::Rating::THE_STREET => :the_street_client,
    Entities::Rating::ZACKS => :zacks_client
  }

  def by_company(company)
    SOURCE_AND_CLIENTS_BY_COMPANY.map do |source, client|
      args = {
        rating: _rating_from_source_by_company(client: client, company: company),
        source: source
      }

      Entities::Rating.new(args)
    end
  end

  def by_symbol(symbol)
    SOURCES_AND_CLIENTS_BY_SYMBOL.map do |source, client|
      args = {
        rating: _rating_from_source_by_symbol(client: client, symbol: symbol),
        source: source
      }

      Entities::Rating.new(args)
    end
  end

  private

  def _rating_from_source_by_company(client:, company:)
    Allocator.send(client).rating_by_company(company)
  rescue StandardError => e
    Rails.logger.error("Rating failed for client: #{client.to_s}. Symbol: #{company.symbol}. Error: #{e.message}")
    ""
  end

  def _rating_from_source_by_symbol(client:, symbol:)
    Allocator.send(client).rating_by_symbol(symbol)
  rescue StandardError => e
    Rails.logger.error("Rating failed for client: #{client.to_s}. Symbol: #{symbol}.Error: #{e.message}")
    ""
  end
end

module RemoteClients
  def bar_chart_client
    Scraper::BarChartClient.new
  end

  def company_index_client
    Elasticsearch::Client.new(url: ENV["ELASTICSEARCH_URL"])
  end

  def cnn_client
    Scraper::CnnClient.new
  end

  def finn_hub_client
    Api::FinnHub::Client.new
  end

  def github_client
    Scraper::GithubClient.new
  end

  def iex_client
    Api::Iex::Client.new
  end

  def robin_hood_client
    Scraper::RobinHoodClient.new
  end

  def tradier_client
    Api::Tradier::Client.new
  end

  def the_street_client
    Scraper::TheStreetClient.new
  end

  def tip_ranks_client
    Scraper::TipRanksClient.new
  end

  def trading_view_client
    Scraper::TradingViewClient.new
  end

  def we_bull_client
    Scraper::WeBullClient.new
  end

  def wsj_client
    Scraper::WsjClient.new
  end

  def zacks_client
    Scraper::ZacksClient.new
  end
end

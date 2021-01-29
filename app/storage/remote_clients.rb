module RemoteClients
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
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

    def trading_view_client
      Scraper::TradingViewClient.new
    end

    def twelve_data_client
      Api::TwelveData::Client.new
    end
  end
end
